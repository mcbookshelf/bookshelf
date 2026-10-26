from mcbookshelf import constants
from mcbookshelf.workspace import Workspace


def version(ws: Workspace) -> str:
    """Read the version of the release, the one of the suite bundle."""
    return ws.suite().version


def tag(ws: Workspace) -> str:
    """Name the release tag: the suite version and the game version it targets."""
    return f"v{version(ws)}+{constants.GAME_VERSION}"


def raw_file(ws: Workspace, name: str, file: str) -> str:
    """Link a file of a module or bundle directory at the release tag."""
    return f"{constants.RAW_URL.format(tag(ws))}/modules/{name}/{file}"


def download_url(ws: Workspace) -> str:
    """Link the assets of the release on GitHub."""
    return constants.DOWNLOAD_URL.format(tag(ws))
