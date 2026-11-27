from collections.abc import Callable
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from mcbookshelf import constants
from mcbookshelf.references import groups

from . import model, rules, syntax
from .diagnostics import Diagnostics, MetadataError
from .expansion import Expander
from .names import Names
from .resolver import TypeResolver
from .slots import SlotBuilder, validate_groups
from .storages import Storages

INDEX_URL = f"{constants.DOCS_PAGES_URL}/index.html"

MISSING_METADATA = "'{}' is missing: write it in the feature, in the lines it pastes or in the head"


def build_module(document: syntax.Module, name: str, file: Path | None = None) -> model.Module:
    """Build a module model from a parsed document, raising every error found at once."""
    return _build(_Builder.module, document, name, file)


def build_bundle(document: syntax.Module, name: str, file: Path | None = None) -> model.Bundle:
    """Build a bundle model from a parsed document, raising every error found at once."""
    return _build(_Builder.bundle, document, name, file)


def _build[T](
    build: Callable[[_Builder, syntax.Module], T],
    document: syntax.Module,
    name: str,
    file: Path | None,
) -> T:
    report = Diagnostics(file)
    built = build(_Builder(name, report), document)
    if report.items:
        raise MetadataError(report.items)
    return built


def _anchor(name: str, resource: str, *, shared: bool) -> str:
    anchor = name.replace("/", "-").replace("_", "-")
    return f"{anchor}-{resource.replace('/', '-')}" if shared else anchor


def _module_url(namespace: str) -> str:
    return f"{constants.DOCS_PAGES_URL}/modules/{model.short(namespace)}.html"


@dataclass(frozen=True, slots=True)
class _Value:

    value: Any
    line: int


@dataclass
class _Builder:

    id: str
    report: Diagnostics
    names: Names = field(init=False)
    types: TypeResolver = field(init=False)
    storages: Storages = field(init=False)

    def __post_init__(self) -> None:
        self.names = Names(self.report)
        self.types = TypeResolver(self.names, self.report)
        self.storages = Storages(self.report)

    def bundle(self, document: syntax.Module) -> model.Bundle:
        if document.features:
            self.report.error("a bundle declares no feature", document.features[0].line)
        if document.definitions:
            self.report.error("a bundle declares no '$' name", document.definitions[0].line)
        if document.metadata:
            self.report.error("a bundle carries no metadata", document.metadata[0].line)
        properties = self.properties(document.properties, rules.BUNDLE_PROPERTIES, 1)

        return model.Bundle(
            id=self.id,
            name=properties["name"].value,
            slug=properties["slug"].value,
            version=properties["version"].value,
            description=self.description(document),
            documentation=properties["documentation"].value or INDEX_URL,
            tags=properties["tags"].value,
        )

    def module(self, document: syntax.Module) -> model.Module:
        properties = self.properties(document.properties, rules.MODULE_PROPERTIES, 1)
        documentation = properties["documentation"].value or _module_url(self.id)
        for line in document.metadata:
            if line.key == "contributors":
                message = "'contributors' is written on features, not in the head"
                self.report.error(message, line.line)
        self.names.define(document.definitions)
        self.types.build_declared()

        features = {}
        head = document.metadata
        expander = Expander(self.names, self.report)
        nodes = [node for feature in document.features for node in expander.repeat(feature, head)]
        names = [self.feature_name(node) for node in nodes]
        folders = groups(names)
        for node, name in zip(nodes, names, strict=True):
            if name in folders:
                message = f"'{name}' is also the folder of other features, which share its files"
                self.report.error(message, node.line)
            key = (rules.REGISTRIES[node.registry].resource, name)
            if key in features:
                first = features[key].line
                message = f"{key[0]} {name} is already declared on line {first}"
                self.report.error(message, node.line)
                continue
            shared = names.count(name) > 1
            features[key] = self.feature(node, name, documentation, shared=shared)
        validate_groups(tuple(features.values()), self.report)

        return model.Module(
            id=self.id,
            name=properties["name"].value,
            slug=properties["slug"].value,
            version=properties["version"].value,
            description=self.description(document),
            documentation=documentation,
            tags=properties["tags"].value,
            weak_dependencies=properties["weak_dependencies"].value,
            features=tuple(features.values()),
            storages=dict(sorted(self.storages.declared.items())),
        )

    def description(self, document: syntax.Module) -> str:
        if document.description is None:
            self.report.error("missing description: write it with '>' on the first line", 1)
            return ""
        return document.description

    def properties(
        self,
        nodes: tuple[syntax.Property | syntax.Metadata, ...],
        fields: dict[str, rules.Field],
        line: int,
        missing: str = "missing property '{}'",
    ) -> dict[str, _Value]:
        """Read every known property; a missing or invalid one gets its default."""
        values: dict[str, _Value] = {}
        for node in nodes:
            spec = fields.get(node.key)
            if spec is None:
                self.report.error(f"unknown property '{node.key}'", node.line)
            elif node.key in values:
                first = values[node.key].line
                self.report.error(f"'{node.key}' is already declared on line {first}", node.line)
            else:
                try:
                    value = spec.parse(node.value or "")
                except ValueError as error:
                    self.report.error(str(error), node.line)
                    value = spec.default
                values[node.key] = _Value(value, node.line)

        for key, spec in fields.items():
            if key not in values:
                if spec.required:
                    self.report.error(missing.format(key), line)
                values[key] = _Value(spec.default, line)

        return values

    def feature_name(self, node: syntax.Feature) -> str:
        namespace, sep, name = node.id.partition(":")
        if not sep:
            name = node.id
        elif namespace != self.id:
            self.report.error(f"'{node.id}' is not in the namespace of the module", node.line)
        if name.startswith("__"):
            self.report.error("a feature id cannot start with '__'", node.line)
        return name

    def feature(
        self,
        node: syntax.Feature,
        name: str,
        documentation: str,
        *,
        shared: bool,
    ) -> model.Feature:
        # a metadata line replaces the same one written before it: the head, then the pasted lines
        metadata = {line.key: line for line in node.lines if isinstance(line, syntax.Metadata)}
        valued = tuple(line for line in metadata.values() if line.key in rules.FEATURE_METADATA)
        values = self.properties(valued, rules.FEATURE_METADATA, node.line, MISSING_METADATA)

        builder = SlotBuilder(self.id, node.registry, name, self.types, self.storages, self.report)
        slots = builder.slots(node)
        resource = rules.REGISTRIES[node.registry].resource
        anchor = _anchor(name, resource, shared=shared)

        return model.Feature(
            module=self.id,
            resource=resource,
            name=name,
            description=node.description,
            documentation=f"{documentation}#{anchor}",
            anchor=anchor,
            authors=values["authors"].value,
            contributors=values["contributors"].value,
            created=model.Stamp(*values["since"].value),
            slots=slots,
            line=node.line,
            deprecated="deprecated" in metadata,
            experimental="experimental" in metadata,
        )
