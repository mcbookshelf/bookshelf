from __future__ import annotations

import logging
import re
from asyncio import create_subprocess_exec, subprocess
from dataclasses import dataclass, field
from typing import TYPE_CHECKING

from bookshelf.common import utils

if TYPE_CHECKING:
    from collections.abc import AsyncIterable, Callable
    from pathlib import Path

logger = logging.getLogger(__name__)


@dataclass
class LogEvent:
    """Structured log event emitted by a PackTest server."""

    message: str
    severity: int
    extra: dict = field(default_factory=dict)

    def log(self, logger: logging.Logger = logger) -> None:
        """Send this event into a logger."""
        logger.log(self.severity, self.message, extra=self.extra)


@dataclass
class LogRule:
    """Represents a structured logging rule for parsing server output lines."""

    pattern: re.Pattern
    message: str = "{text}"
    severity: int = logging.ERROR
    formatter: Callable[[re.Match], dict] = lambda match: match.groupdict()

    def match(self, line: str) -> LogEvent | None:
        """Attempt to match the pattern and return a LogEvent if matched."""
        if match := self.pattern.search(line):
            extra = self.formatter(match)
            return LogEvent(
                self.message.format(**extra),
                self.severity,
                {k: v for k, v in extra.items() if k in ("title", "file", "line")},
            )
        return None


def _format_test_error(match: re.Match) -> dict:
    name = match["name"]
    i = name.rfind(":", 0, name.find("/"))
    # Infer the module path and test file from the test name
    return {
        **match.groupdict(),
        "title": f"Test '{name}' failed",
        "file": f"modules/{name[:i]}/data/{name[:i]}/test/{name[i+1:]}.mcfunction",
        "line": int(match["line"]) - 1,
    }


LOG_RULES = [
    LogRule(re.compile(
        r"::error title=Test (?P<name>bs.*?) "
        r"failed on line (?P<line>\d+)!::(?P<text>.*)",
    ), formatter=_format_test_error),
    LogRule(re.compile(
        r"::error title=(?P<title>.*?)::(?P<text>.*)",
    )),
    LogRule(re.compile(
        r"Running test environment 'bs.load:(?P<name>.*?)' batch 0 "
        r"\((?P<count>\d+) tests\)",
    ), "Test 'bs.{name}' module ({count} tests)", logging.INFO),
    LogRule(re.compile(
        r"(?P<count>\d+) tests are now running at position "
        r"(?P<x>-?\d+), (?P<y>-?\d+), (?P<z>-?\d+)!",
    ), "Run {count} tests at position ({x}, {y}, {z})", logging.INFO),
]


async def run(cwd: Path, server: str = "server.jar") -> AsyncIterable[LogEvent]:
    """Run the PackTest server, parses its output, and capture relevant logs."""
    flags = [
        "-Xms3G",
        "-Xmx3G",
        "-XX:+UseG1GC",
        "-XX:MaxGCPauseMillis=100",
        "-XX:+UnlockExperimentalVMOptions",
        "-XX:+DisableExplicitGC",
        "-XX:+AlwaysPreTouch",
        "-XX:G1NewSizePercent=30",
        "-XX:G1MaxNewSizePercent=40",
        "-XX:G1HeapRegionSize=8M",
        "-XX:G1ReservePercent=20",
        "-XX:G1HeapWastePercent=5",
        "-XX:G1MixedGCCountTarget=4",
        "-XX:InitiatingHeapOccupancyPercent=15",
        "-XX:G1MixedGCLiveThresholdPercent=90",
        "-XX:G1RSetUpdatingPauseTimePercent=5",
        "-XX:SurvivorRatio=32",
        "-XX:+PerfDisableSharedMem",
        "-XX:MaxTenuringThreshold=1",
        "-XX:+UseStringDeduplication",
        "-XX:+ParallelRefProcEnabled",
        "-Dpacktest.auto",
        "-Dpacktest.auto.annotations",
        "-jar",
    ]
    # Start the server process inside the given directory
    process = await create_subprocess_exec(
        *[utils.locate_command("java"), *flags, server, "nogui"],
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    # Stream output line-by-line and attempt to match with log rules
    if stdout := process.stdout:
        while (raw := await stdout.readline()):
            line = raw.decode("utf-8", errors="replace").rstrip()
            for rule in LOG_RULES:
                if event := rule.match(line):
                    yield event
                    break

    await process.wait()
