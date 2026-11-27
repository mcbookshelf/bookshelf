from dataclasses import dataclass, field, replace

from . import model, syntax
from .diagnostics import Diagnostics


@dataclass
class Storages:
    """The storages a module writes to, each as the struct of everything declared in it."""

    report: Diagnostics
    declared: dict[str, model.Storage] = field(default_factory=dict)

    def add(self, target: model.Target, value: syntax.Type | None, line: int) -> None:
        if value is None:
            self.report.error("a storage needs a type", line)
            return

        *parents, name = target.keys
        entry = syntax.Entry(name=name, type=value, optional=True, line=line)
        for parent in reversed(parents):
            struct = syntax.Struct(entries=(entry,), line=line)
            entry = syntax.Entry(name=parent, type=struct, optional=True, line=line)

        declared = syntax.Struct(entries=(entry,), line=line)
        storage = self.declared.get(target.id)
        self.declared[target.id] = replace(
            storage,
            struct=self.merge(storage.struct, declared, target.id),
        ) if storage else model.Storage(target.id, declared)

    def merge(self, first: syntax.Struct, second: syntax.Struct, id_: str) -> syntax.Struct:
        entries = list(first.entries)
        names = {e.name: i for i, e in enumerate(entries)}

        for entry in second.entries:
            index = names.get(entry.name)
            if index is None:
                names[entry.name] = len(entries)
                entries.append(entry)
                continue

            previous = entries[index]
            if isinstance(previous.type, syntax.Struct) and isinstance(entry.type, syntax.Struct):
                merged = self.merge(previous.type, entry.type, id_)
                entries[index] = replace(previous, type=merged)
            elif previous.type != entry.type:
                self.report.error(
                    f"'{entry.name}' of storage {id_} is already declared "
                    f"as '{previous.type}' on line {previous.line}",
                    entry.line,
                )

        return replace(first, entries=tuple(entries))
