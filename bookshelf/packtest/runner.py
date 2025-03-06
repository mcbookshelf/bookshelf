import re
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from types import MappingProxyType

from bookshelf.logger import StepLogger, log_step
from bookshelf.packtest.assets import Assets


@dataclass
class Runner:
    """Utility for setting up and running PackTest."""

    assets: Assets

    PATTERNS = MappingProxyType({
        "any_error": re.compile(r"::error title=(?P<title>.*?)::(?P<message>.*)"),
        "test_error": re.compile(
            r"::error title=Test (?P<name>.*?) "
            r"failed on line (?P<line>\d+)!::(?P<message>.*)",
        ),
        "test_batch": re.compile(
            r"Running test batch '(?P<name>.*?):0' "
            r"\((?P<count>\d+) tests\)",
        ),
    })

    def run(self, rundir: Path) -> int:
        """Run Packtest in the specified directory."""
        self.assets.download(rundir)
        with log_step("🧪 Running test server…") as logger:
            java = shutil.which("java")
            if not java:
                error_msg = "The 'java' command was not found."
                raise FileNotFoundError(error_msg)

            cmd = [
                java,
                "-Xmx2G",
                "-Dpacktest.auto",
                "-Dpacktest.auto.annotations",
                "-jar",
                "server.jar",
                "nogui",
            ]
            process = subprocess.Popen(
                cmd,
                cwd=rundir,
                encoding="utf-8",
                errors="replace",
                text=True,
                stdout=subprocess.PIPE,
                universal_newlines=True,
            )
            self._monitor_process(process, logger)
        return process.wait()

    def _handle_any_error(self, match: re.Match, logger: StepLogger) -> None:
        """Handle generic errors detected in the process output."""
        logger.error(match["message"], extra={"title": match["title"]})

    def _handle_test_batch(self, match: re.Match, logger: StepLogger) -> None:
        """Handle test batch start logs."""
        logger.debug(
            "Test '%s' module (%s tests)",
            match["name"],
            int(match["count"]) - 1,
        )

    def _handle_test_error(self, match: re.Match, logger: StepLogger) -> None:
        """Handle individual test error logs."""
        name = match["name"]
        i = name.rfind(".", 0, name.find("/"))
        logger.error(match["message"], extra={
            "title": f"Test '{name}' failed",
            "file": f"modules/{name[:i]}/data/{name[:i]}/test/{name[i+1:]}.mcfunction",
            "line": int(match["line"]) - 1,
        })

    def _monitor_process(self, process: subprocess.Popen, logger: StepLogger) -> None:
        """Monitor and process the output of the test server."""
        if not process.stdout:
            return
        for line in iter(process.stdout.readline, ""):
            for pattern, callback in (
                (self.PATTERNS["test_error"], self._handle_test_error),
                (self.PATTERNS["test_batch"], self._handle_test_batch),
                (self.PATTERNS["any_error"], self._handle_any_error),
            ):
                if match := pattern.search(line):
                    callback(match, logger)
                    break
