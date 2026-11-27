import re
from collections.abc import Callable, Iterator
from dataclasses import dataclass, replace
from itertools import product
from typing import Any

from . import syntax
from .diagnostics import Diagnostics
from .names import Names

TEXT_REFERENCE = re.compile(r"\$([A-Za-z_][A-Za-z0-9_]*)(?:\.([A-Za-z_][A-Za-z0-9_]*))?")

type Text = Callable[[str, int], str]


@dataclass
class Expander:
    """Expands a feature as written: the lines it pastes, and a copy per item of its lists."""

    names: Names
    report: Diagnostics

    def repeat(
        self,
        node: syntax.Feature,
        head: tuple[syntax.Metadata, ...],
    ) -> Iterator[syntax.Feature]:
        """A feature with the lines it inherits and pastes, once per item of the lists of its id."""
        lines = (*head, *self.lines(node.lines))
        names: list[str] = []
        for match in TEXT_REFERENCE.finditer(node.id):
            if match[1] not in self.names.lists:
                self.report.error(f"'${match[1]}' is not a list", node.line)
            elif match[1] not in names:
                names.append(match[1])

        def check(value: str, line: int) -> str:
            for match in TEXT_REFERENCE.finditer(value):
                self.validate_reference(match[1], match[2], names, node.id, line)
            return value

        if node.description:
            check(node.description, node.line)
        for line in lines:
            _texts(line, check)

        for items in product(*(self.names.lists[name].items.items() for name in names)):
            chosen = dict(zip(names, items, strict=True))

            def text(value: str, _line: int, chosen: dict[str, Any] = chosen) -> str:
                return self.substitute(value, chosen)

            yield replace(
                node,
                id=text(node.id, node.line),
                description=node.description and text(node.description, node.line),
                lines=tuple(_texts(line, text) for line in lines),
            )

    def lines(self, body: tuple[Any, ...], stack: tuple[str, ...] = ()) -> Iterator[syntax.Line]:
        """The lines of a block, the pasted ones in place of their paste."""
        for line in body:
            if not isinstance(line, syntax.Paste):
                yield line
            elif line.name in stack:
                path = " > ".join(f"${s}" for s in stack)
                self.report.error(f"'${line.name}' pastes itself through {path}", line.line)
            elif (definition := self.names.lookup(line.name, line.line, "lines")) is not None:
                yield from self.lines(definition.body, (*stack, line.name))

    def validate_reference(
        self,
        name: str,
        key: str | None,
        names: list[str],
        feature: str,
        line: int,
    ) -> None:
        """A list written in a text is one of the id, and its key one every item gives."""
        found = self.names.lists.get(name)
        if found is None:
            return
        if name not in names:
            self.report.error(f"the list '${name}' is not in the id of '{feature}'", line)
        elif key in found.keys:
            missing = [f"'{item}'" for item, values in found.items.items() if key not in values]
            if missing:
                items = f"item{'s' if len(missing) > 1 else ''} {', '.join(missing)}"
                self.report.error(f"'${name}.{key}' is not defined for the {items}", line)

    def substitute(self, value: str, chosen: dict[str, tuple[str, dict[str, str]]]) -> str:
        """Replace `$list` by its item and `$list.key` by the text the item gives for the key."""

        def replacement(match: re.Match[str]) -> str:
            name, key = match[1], match[2]
            if name not in chosen:
                return match[0]
            item, values = chosen[name]
            if key is None:
                return item
            keys = self.names.lists[name].keys
            return values.get(key, match[0]) if key in keys else f"{item}.{key}"

        return TEXT_REFERENCE.sub(replacement, value)


def _texts(node: Any, text: Text) -> Any:  # noqa: ANN401
    """A line or a field with its texts rewritten: its value, its doc and the ones of its fields."""
    match node:
        case syntax.Metadata(value=str() as value):
            return replace(node, value=text(value, node.line))
        case syntax.Slot() | syntax.Field():
            description = node.description and text(node.description, node.line)
            fields = tuple(_texts(f, text) for f in node.fields)
            return replace(node, description=description, fields=fields)
    return node
