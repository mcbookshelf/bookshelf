from enum import IntEnum
from typing import NamedTuple


class Bump(IntEnum):
    """The part of a version a change raises."""

    NONE = 0
    PATCH = 1
    MINOR = 2
    MAJOR = 3


class Version(NamedTuple):

    major: int
    minor: int
    patch: int

    @classmethod
    def parse(cls, text: str) -> Version:
        major, minor, patch = (int(part) for part in text.split("."))
        return cls(major, minor, patch)

    def __str__(self) -> str:
        return f"{self.major}.{self.minor}.{self.patch}"

    def bump(self, level: Bump) -> Version:
        match level:
            case Bump.MAJOR:
                return Version(self.major + 1, 0, 0)
            case Bump.MINOR:
                return Version(self.major, self.minor + 1, 0)
            case Bump.PATCH:
                return Version(self.major, self.minor, self.patch + 1)
        return self

    def change(self, other: Version) -> Bump:
        """The highest part that differs between the two versions."""
        levels = (Bump.MAJOR, Bump.MINOR, Bump.PATCH)
        for level, old, new in zip(levels, self, other, strict=True):
            if old != new:
                return level
        return Bump.NONE
