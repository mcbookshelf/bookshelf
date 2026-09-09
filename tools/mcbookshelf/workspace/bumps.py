from collections.abc import Iterable, Iterator
from dataclasses import dataclass
from enum import IntEnum
from pathlib import Path

from mcbookshelf import workspace
from mcbookshelf.meta import parse_version
from mcbookshelf.workspace import changelog, dependencies, history, ownership
from mcbookshelf.workspace.changelog import write_text

type Plan = dict[str, Expectation | None]

BREAKING = "⚠️"
FEATURE = "✨"
DEPENDENCY_NOTE = "🛠️ Bumped as {}"


class Bump(IntEnum):

    NONE = 0
    PATCH = 1
    MINOR = 2
    MAJOR = 3


@dataclass(frozen=True, slots=True)
class Expectation:

    name: str
    current: str
    expected: str
    reason: str
    note: str | None = None


@dataclass(frozen=True, slots=True)
class Move:

    bump: Bump
    reason: str

    @staticmethod
    def unchanged() -> Move:
        return Move(Bump.NONE, "unchanged")


def expectations(tag: str) -> Iterator[Expectation]:
    """Yield the version changes required since a tag, dependencies first."""
    plan: Plan = {}
    for name in workspace.released():
        _plan_module(tag, name, plan)
    yield from (expectation for expectation in plan.values() if expectation)
    for name in workspace.bundles():
        yield from _plan_bundle(tag, name, plan)


def apply(expectation: Expectation) -> None:
    """Apply a version expectation to the workspace."""
    name, version = expectation.name, expectation.expected
    _write_version(workspace.file(name), version)
    if name in workspace.bundles():
        return
    if expectation.note:
        changelog.note(name, expectation.note)
    changelog.promote(name, version)


def problems(tag: str) -> Iterator[str]:
    """Yield release problems that need manual fixes."""
    for name in workspace.released():
        module = workspace.load_module(name)
        before = history.module_at(tag, name)
        if before is None or module.version == before.version:
            continue
        if changelog.unreleased(name):
            yield f"{name}: rename the 'Unreleased' section to v{module.version}"
        elif not changelog.section(name, module.version):
            yield f"{name}: the changelog has no notes for v{module.version}"


def _plan_module(tag: str, name: str, plan: Plan) -> None:
    if name in plan:
        return
    plan[name] = None
    module = workspace.load_module(name)
    before = history.module_at(tag, name)
    if before is None or not module.released:
        return
    dependency = _strongest(_dependency_moves(tag, name, plan))
    strongest = _strongest([_changelog_move(name), dependency, _sources_move(tag, name)])
    expected = _bumped(before.version, strongest.bump)
    if parse_version(module.version) < parse_version(expected):
        note = None
        if strongest.bump == dependency.bump and not changelog.unreleased(name):
            note = DEPENDENCY_NOTE.format(dependency.reason)
        plan[name] = Expectation(name, module.version, expected, strongest.reason, note)


def _plan_bundle(tag: str, name: str, plan: Plan) -> Iterator[Expectation]:
    before = history.bundle_at(tag, name)
    if before is None:
        return
    bundle = workspace.load_bundle(name)
    was = history.members_at(tag, name)
    now = {member: _planned_version(member, plan) for member in workspace.members(name)}
    strongest = _strongest(_member_moves(was, now))
    expected = _bumped(before.version, strongest.bump)
    if parse_version(bundle.version) < parse_version(expected):
        yield Expectation(name, bundle.version, expected, strongest.reason)


def _planned_version(name: str, plan: Plan) -> str:
    expectation = plan.get(name)
    return expectation.expected if expectation else workspace.load_module(name).version


def _changelog_move(name: str) -> Move:
    notes = changelog.unreleased(name)
    if BREAKING in notes:
        return Move(Bump.MAJOR, "the changelog notes a breaking change")
    if FEATURE in notes:
        return Move(Bump.MINOR, "the changelog notes a new feature")
    if notes:
        return Move(Bump.PATCH, "the changelog notes a change")
    return Move.unchanged()


def _dependency_moves(tag: str, name: str, plan: Plan) -> Iterator[Move]:
    for dependency in dependencies.strong(name):
        _plan_module(tag, dependency, plan)
        before = history.module_at(tag, dependency)
        if before is not None:
            target = _planned_version(dependency, plan)
            yield Move(_compare(before.version, target), f"`{dependency}` moved to `v{target}`")


def _sources_move(tag: str, name: str) -> Move:
    experimental = workspace.load_module(name).experimental
    for owner, paths in ownership.changed_owners(tag, name).items():
        if owner.feature not in experimental:
            return Move(Bump.PATCH, f"{paths[0]} changed")
    return Move.unchanged()


def _member_moves(was: dict[str, str], now: dict[str, str]) -> Iterator[Move]:
    for member in sorted(was.keys() | now.keys()):
        if member not in now:
            yield Move(Bump.MAJOR, f"{member} left the bundle")
        elif member not in was:
            yield Move(Bump.MINOR, f"{member} joined the bundle")
        else:
            level = _compare(was[member], now[member])
            yield Move(level, f"`{member}` moved to `v{now[member]}`")


def _bumped(version: str, bump: Bump) -> str:
    major, minor, patch = parse_version(version)
    match bump:
        case Bump.MAJOR:
            return f"{major + 1}.0.0"
        case Bump.MINOR:
            return f"{major}.{minor + 1}.0"
        case Bump.PATCH:
            return f"{major}.{minor}.{patch + 1}"
    return version


def _compare(before: str, after: str) -> Bump:
    levels = (Bump.MAJOR, Bump.MINOR, Bump.PATCH)
    for level, old, new in zip(levels, parse_version(before), parse_version(after), strict=True):
        if old != new:
            return level
    return Bump.NONE


def _strongest(moves: Iterable[Move]) -> Move:
    return max(moves, key=lambda move: move.bump, default=Move.unchanged())


def _write_version(file: Path, version: str) -> None:
    lines = file.read_text("utf-8").splitlines()
    for index, line in enumerate(lines):
        if line.startswith("version:"):
            lines[index] = f"version: {version}"
            break
    write_text(file, "\n".join(lines))
