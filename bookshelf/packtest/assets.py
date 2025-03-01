from pathlib import Path

import requests

from bookshelf.definitions import FABRIC_API, MODRINTH_API
from bookshelf.logger import StepLogger, log_step


class Assets:
    """Utility for managing assets required to run PackTest."""

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
            f"{FABRIC_API}/versions/loader/{mc_version}",
            timeout=5,
        )
        response.raise_for_status()
        version = response.json()[0]["loader"]["version"]
        return f"{FABRIC_API}/versions/loader/{mc_version}/{version}/1.0.1/server/jar"

    def _get_modrinth_url(self, project_id: str, mc_version: str) -> str:
        """Get the URL for downloading a Modrinth project."""
        response = requests.get(
            f"{MODRINTH_API}/project/{project_id}/version",
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
