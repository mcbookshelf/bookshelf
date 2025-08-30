from __future__ import annotations

from enum import Enum
from re import escape
from typing import TYPE_CHECKING, Any

from pydantic import BaseModel, Field

from bookshelf.common import utils
from bookshelf.definitions import DOC_URL, MODULES_DIR

if TYPE_CHECKING:
    from collections.abc import Callable


def make_url_resolver(file: str) -> Callable[[dict[str, Any]], str | None]:
    """Return a resolver that builds a GitHub URL for the given file in a module."""
    def resolve_url(data: dict[str, Any]) -> str | None:
        path = MODULES_DIR / data["id"] / file
        if not path.exists():
            return None
        return utils.raw_github_url(path)
    return resolve_url


class ModuleKind(Enum):
    """Represents a type of module."""

    DATA_PACK = "data_pack"
    RESOURCE_PACK = "resource_pack"


class Manifest(BaseModel, frozen=True):
    """The full manifest of the Bookshelf project."""

    version: str = "v2"
    modules: list[Module]


class Module(BaseModel, frozen=True):
    """Represents metadata for a module within the library."""

    id: str = Field(pattern=r"^bs\..+$")
    name: str
    slug: str
    icon: str | None = Field(default_factory=make_url_resolver("pack.png"))
    banner: str | None = Field(default_factory=make_url_resolver("banner.png"))
    readme: str | None = Field(default_factory=make_url_resolver("README.md"))
    description: str
    documentation: str = Field(pattern=rf"^{escape(DOC_URL)}/en/latest/modules/.+$")

    kind: ModuleKind
    tags: list[str]
    authors: list[str] = Field(default_factory=list)
    contributors: list[str] = Field(default_factory=list)
    dependencies: list[str] = Field(default_factory=list)
    weak_dependencies: list[str] = Field(default_factory=list)

    features: list[Feature] = Field(default_factory=list)


class Feature(BaseModel, frozen=True):
    """Represents metadata for a feature within the library."""

    id: str
    kind: str
    documentation: str = Field(pattern=rf"^{escape(DOC_URL)}/en/latest/modules/.+$")
    authors: list[str]
    contributors: list[str] = Field(default_factory=list)
    created: Updated
    updated: Updated


class Updated(BaseModel, frozen=True):
    """Represents metadata about when a feature was last updated."""

    # Date string in YYYY/MM/DD format
    date: str = Field(pattern=r"^\d{4}/(0[1-9]|1[0-2])/(0[1-9]|[1-2]\d|3[0-1])$")
    minecraft_version: str
