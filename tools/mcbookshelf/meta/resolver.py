from dataclasses import dataclass, field, replace
from typing import Any

from . import rules, syntax
from .diagnostics import Diagnostics
from .names import Names


@dataclass
class TypeResolver:
    """Builds the types of a document: what a `$` name stands for, and the struct under a line."""

    names: Names
    report: Diagnostics
    built: dict[str, syntax.Type] = field(default_factory=dict)
    building: list[str] = field(default_factory=list)

    def build_declared(self) -> None:
        """Build every type once, where it is declared: an error in it is reported there."""
        for name, definition in self.names.definitions.items():
            if definition.type is not None:
                self.type_of(name, definition.line)

    def type_of(self, name: str, line: int) -> syntax.Type:
        """The type a definition stands for, built once."""
        if name in self.building:
            path = " > ".join(f"${s}" for s in self.building)
            self.report.error(f"'${name}' refers to itself through {path}", line)
            return rules.ANY
        if name not in self.built:
            definition = self.names.lookup(name, line, "a type")
            if definition is None:
                return rules.ANY
            self.building.append(name)
            built = self.resolve(definition.type, definition.body, definition.line)
            self.building.pop()
            self.built[name] = built or rules.ANY
        return self.built[name]

    def resolve(
        self,
        value: syntax.Type | None,
        fields: tuple[Any, ...],
        line: int,
    ) -> syntax.Type | None:
        """Build the type of a line from what is written on it and the fields under it."""
        if value is None:
            return self.struct(fields, line) if fields else None
        words = _structs(value)
        if words > 1:
            message = "a line has one 'struct', since one block of fields follows it"
            self.report.error(f"{message}: name the others with '$'", line)
        elif fields and not words:
            self.report.error(f"these fields belong to no struct: '{value}' holds none", line)
        return self.expand(value, fields, line)

    def expand(self, value: syntax.Type, fields: tuple[Any, ...], line: int) -> syntax.Type:
        match value:
            case syntax.Reference():
                return self.expand_reference(value)
            case syntax.List(element=el):
                return replace(value, element=self.expand(el, fields, line))
            case syntax.Tuple(elements=els):
                return replace(value, elements=tuple(self.expand(e, fields, line) for e in els))
            case syntax.Union(members=members):
                return replace(value, members=tuple(self.expand(m, fields, line) for m in members))
            case syntax.Struct():
                return replace(self.struct(fields, line), attributes=value.attributes)
        return value

    def struct(self, fields: tuple[Any, ...], line: int) -> syntax.Struct:
        """A struct from the fields of a block: a pasted struct adds its own fields."""
        entries: dict[str, syntax.Entry] = {}
        declared: dict[str, int] = {}
        for item in fields:
            if isinstance(item, syntax.Paste):
                pasted = self.type_of(item.name, item.line)
                if isinstance(pasted, syntax.Struct):
                    entries.update((e.name, e) for e in pasted.entries)
                elif item.name in self.names.definitions and pasted is not rules.ANY:
                    self.report.error(f"'${item.name}' is a type, not a struct", item.line)
            elif not isinstance(item, syntax.Field):
                continue
            elif item.name in declared:
                message = f"'{item.name}' is already declared on line {declared[item.name]}"
                self.report.error(message, item.line)
            else:
                declared[item.name] = item.line
                entries[item.name] = self.entry(item)
        return syntax.Struct(entries=tuple(entries.values()), line=line)

    def entry(self, item: syntax.Field) -> syntax.Entry:
        built = self.resolve(item.type, item.fields, item.line)
        return syntax.Entry(
            name=item.name,
            type=built or rules.ANY,
            optional=item.optional,
            description=item.description or self.alias_description(item.type),
            line=item.line,
        )

    def alias_description(self, value: syntax.Type | None) -> str | None:
        """The doc a line or a field takes from the type it uses when it has none."""
        if not isinstance(value, syntax.Reference):
            return None
        definition = self.names.definitions.get(value.name)
        return definition.description if definition else None

    def expand_reference(self, reference: syntax.Reference) -> syntax.Type:
        name, line = reference.name, reference.line
        resolved = self.type_of(name, line)
        if not reference.attributes:
            return resolved

        if isinstance(resolved, syntax.Union):
            self.report.error(f"'${name}' cannot take an attribute, it is a '{resolved}'", line)
            return resolved

        return replace(resolved, attributes=(*reference.attributes, *resolved.attributes))

    def validate_data_type(self, value: syntax.Type | None, line: int) -> None:
        match value:
            case syntax.Primitive(kind=kind) if kind in rules.CONTEXT_ONLY:
                self.report.error(f"'{kind}' is not a data type", line)
            case syntax.Array(element=element) | syntax.List(element=element):
                self.validate_data_type(element, line)
            case syntax.Tuple(elements=elements) | syntax.Union(members=elements):
                for element in elements:
                    self.validate_data_type(element, line)
            case syntax.Struct(entries=entries):
                for entry in entries:
                    self.validate_data_type(entry.type, entry.line)


def _structs(value: syntax.Type) -> int:
    """How many times a type, as written, holds the word `struct`."""
    match value:
        case syntax.Struct():
            return 1
        case syntax.List(element=element):
            return _structs(element)
        case syntax.Tuple(elements=elements) | syntax.Union(members=elements):
            return sum(map(_structs, elements))
    return 0
