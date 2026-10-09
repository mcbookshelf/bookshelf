from dataclasses import dataclass

from mcbookshelf.meta.diagnostics import locate


@dataclass(frozen=True, slots=True)
class Issue:

    message: str
    path: str
    line: int | None = None

    def __str__(self) -> str:
        return f"{locate(self.path, self.line)}: {self.message}"
