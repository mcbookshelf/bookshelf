from typing import NotRequired, TypedDict


class DownloadEntry(TypedDict):

    modrinth: str | None
    github: str


class VersionStamp(TypedDict):

    date: str
    minecraft_version: str


class VersionEntry(TypedDict):

    tag: str
    version: str
    minecraft: str
    date: str
    modules: dict[str, str]


class FeatureEntry(TypedDict):

    id: str
    kind: str
    documentation: str
    aliases: list[str]
    authors: list[str]
    contributors: list[str]
    created: VersionStamp
    updated: VersionStamp
    files: list[str]
    dependencies: list[str]


class PackEntry(TypedDict):

    id: str
    name: str
    slug: str
    kind: str
    version: str
    description: str
    documentation: str
    icon: str
    readme: str
    file: str
    stub: str
    tags: list[str]
    download: NotRequired[DownloadEntry]


class ModuleEntry(PackEntry):

    files: list[str]
    dependencies: list[str]
    weak_dependencies: list[str]
    features: list[FeatureEntry]


class BundleEntry(PackEntry):

    modules: list[str]


class Manifest(TypedDict):

    version: int
    release: str
    minecraft: str
    bundles: dict[str, BundleEntry]
    modules: dict[str, ModuleEntry]
