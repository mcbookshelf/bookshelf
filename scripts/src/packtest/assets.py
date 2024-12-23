from logger import BaseLogger
from pathlib import Path
import requests

requests.packages.urllib3.util.connection.HAS_IPV6 = False

class Assets:
    """
    Utility for managing assets required to run Minecraft Unit Tests.
    """

    def __init__(self, mc_version: str) -> None:
        self.mc_version = mc_version
        self.fabric_server_url = get_fabric_url(mc_version)
        self.fabric_api_url = get_modrinth_url("fabric-api", mc_version)
        self.packtest_url = get_modrinth_url("packtest", mc_version)

    def download(self, target: Path, logger: BaseLogger):
        logger.step("🚀 Downloading assets…")
        for url, filepath in [
            (self.fabric_server_url, target / "server.jar"),
            (self.fabric_api_url, target / "mods/fabric-api.jar"),
            (self.packtest_url, target / "mods/packtest.jar"),
        ]:
            if not filepath.exists():
                logger.print(f"Fetch {url}")
                response = requests.get(url)
                response.raise_for_status()
                filepath.parent.mkdir(parents=True, exist_ok=True)
                filepath.write_bytes(response.content)


def get_fabric_url(mc_version: str) -> str:
    response = requests.get(f"https://meta.fabricmc.net/v2/versions/loader/{mc_version}")
    response.raise_for_status()
    versions = response.json()
    return f'https://meta.fabricmc.net/v2/versions/loader/{mc_version}/{versions[0]["loader"]["version"]}/1.0.1/server/jar'


def get_modrinth_url(project_id: str, mc_version: str) -> str:
    response = requests.get(f"https://api.modrinth.com/v2/project/{project_id}/version")
    response.raise_for_status()
    versions = response.json()
    if versions := [
            version
            for version in versions
            if any(v.startswith(mc_version) for v in version["game_versions"])
        ]:
        return versions[0]["files"][0]["url"]
    raise RuntimeError(f"Could not find a version for {project_id} that matches the MC version: {mc_version}")
