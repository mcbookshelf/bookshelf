import re
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from types import MappingProxyType

import requests

from core.common.logger import StepLogger, log_step


class Assets:
    """Utility for managing assets required to run Minecraft Unit Tests."""

    def __init__(self, mc_version: str) -> None:
        """Initialize the Assets utility."""
        self.mc_version = mc_version
        self.fabric_server_url = self._get_fabric_url(mc_version)
        self.fabric_api_url = self._get_modrinth_url("fabric-api", mc_version)
        self.packtest_url = self._get_modrinth_url("packtest", mc_version)

    def download(self, out: Path) -> None:
        """Download required assets to the specified output directory."""
        with log_step("🚀 Downloading assets…") as logger:
            for url, file_path in [
                (self.fabric_server_url, out / "server.jar"),
                (self.fabric_api_url, out / "mods/fabric-api.jar"),
                (self.packtest_url, out / "mods/packtest.jar"),
            ]:
                self._download_asset(url, file_path, logger)

    def _download_asset(self, url: str, file_path: Path, logger: StepLogger) -> None:
        """Download an asset from a URL to the specified file path."""
        if not file_path.exists():
            logger.debug("Fetching %s", url)
            try:
                response = requests.get(url, timeout=5)
                response.raise_for_status()
                file_path.parent.mkdir(parents=True, exist_ok=True)
                file_path.write_bytes(response.content)
            except requests.RequestException:
                logger.exception("Error downloading %s", url)
                raise

    def _get_fabric_url(self, mc_version: str) -> str:
        """Get the URL for downloading the Fabric server."""
        response = requests.get(
            f"https://meta.fabricmc.net/v2/versions/loader/{mc_version}",
            timeout=5,
        )
        response.raise_for_status()
        versions = response.json()
        return f"https://meta.fabricmc.net/v2/versions/loader/{mc_version}/{versions[0]["loader"]["version"]}/1.0.1/server/jar"

    def _get_modrinth_url(self, project_id: str, mc_version: str) -> str:
        """Get the URL for downloading a Modrinth project."""
        response = requests.get(
            f"https://api.modrinth.com/v2/project/{project_id}/version",
            timeout=5,
        )
        response.raise_for_status()
        versions = response.json()
        if versions := [
            version
            for version in versions
            if any(v.startswith(mc_version) for v in version["game_versions"])
        ]:
            return versions[0]["files"][0]["url"]

        error_msg = (
            f"Could not find a version for {project_id} "
            "that matches the MC version: {mc_version}"
        )
        raise RuntimeError(error_msg)


@dataclass
class Runner:
    """Utility for setting up and running Minecraft Unit Tests."""

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
