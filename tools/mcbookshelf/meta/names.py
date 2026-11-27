from dataclasses import dataclass, field

from . import syntax
from .diagnostics import Diagnostics


@dataclass(slots=True)
class NamedList:
    """A list: its items in the order they are written, with the text each gives for a key."""

    line: int
    items: dict[str, dict[str, str]] = field(default_factory=dict)
    keys: set[str] = field(default_factory=set)


@dataclass
class Names:
    """The `$` names a document declares: types, lines to paste, and lists."""

    report: Diagnostics
    definitions: dict[str, syntax.Definition] = field(default_factory=dict)
    lists: dict[str, NamedList] = field(default_factory=dict)

    def define(self, nodes: tuple[syntax.Definition | syntax.Items, ...]) -> None:
        for node in nodes:
            if isinstance(node, syntax.Items):
                self.define_items(node)
            elif (first := self.declared(node.name)) is not None:
                self.report.error(f"'${node.name}' is already declared on line {first}", node.line)
            else:
                self.definitions[node.name] = node

    def define_items(self, node: syntax.Items) -> None:
        if node.name in self.definitions:
            first = self.definitions[node.name].line
            self.report.error(f"'${node.name}' is already declared on line {first}", node.line)
            return
        found = self.lists.setdefault(node.name, NamedList(node.line))
        values: dict[str, str] = {}
        for item in node.properties:
            if item.key in values:
                self.report.error(f"'{item.key}' is already given to these items", item.line)
            values[item.key] = item.value
        for item in node.items:
            if item in found.items:
                self.report.error(f"'{item}' is already an item of '${node.name}'", node.line)
            else:
                found.items[item] = values
        found.keys.update(values)

    def declared(self, name: str) -> int | None:
        """The line a name is declared on, if it is."""
        if name in self.definitions:
            return self.definitions[name].line
        return self.lists[name].line if name in self.lists else None

    def lookup(self, name: str, line: int, wanted: str) -> syntax.Definition | None:
        """Find a definition used as `wanted`: lines, or a type."""
        definition = self.definitions.get(name)
        if definition is None:
            if name in self.lists:
                declared = f"it is declared on line {self.lists[name].line}"
                self.report.error(f"'${name}' is a list, not {wanted}: {declared}", line)
            else:
                self.report.error(f"unknown name '${name}'", line)
            return None

        # a definition without a type is lines
        shape = "lines" if definition.type is None else "a type"
        if shape != wanted:
            declared = f"it is declared on line {definition.line}"
            self.report.error(f"'${name}' is {shape}, not {wanted}: {declared}", line)
            return None

        return definition
