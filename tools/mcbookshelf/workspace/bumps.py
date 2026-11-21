from collections.abc import Iterable, Iterator
from dataclasses import dataclass
from pathlib import Path

from mcbookshelf.version import Bump, Version
from mcbookshelf.workspace import Workspace, changelog, dependencies, history, ownership

type Plan = dict[str, Expectation | None]

BREAKING = "⚠️"
FEATURE = "✨"
DEPENDENCY_NOTE = "🛠️ Bumped as {}"


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


UNCHANGED = Move(Bump.NONE, "unchanged")


def expectations(ws: Workspace, tag: str) -> Iterator[Expectation]:
    """Yield the version changes required since a tag, dependencies first."""
    plan: Plan = {}
    for name in ws.released():
        _plan_module(ws, tag, name, plan)
    yield from (expectation for expectation in plan.values() if expectation)
    for name in ws.bundles():
        yield from _plan_bundle(ws, tag, name, plan)


def apply(ws: Workspace, expectation: Expectation) -> None:
    """Apply a version expectation to the workspace."""
    name, version = expectation.name, expectation.expected
    _write_version(ws.file(name), version)
    if name in ws.bundles():
        return
    if expectation.note:
        changelog.note(ws, name, expectation.note)
    changelog.promote(ws, name, version)


def problems(ws: Workspace, tag: str) -> Iterator[str]:
    """Yield release problems that need manual fixes."""
    for name in ws.released():
        module = ws.load_module(name)
        before = history.module_at(ws, tag, name)
        if before is None or module.version == before.version:
            continue
        if changelog.unreleased(ws, name):
            yield f"{name}: rename the 'Unreleased' section to v{module.version}"
        elif not changelog.section(ws, name, module.version):
            yield f"{name}: the changelog has no notes for v{module.version}"


def _plan_module(ws: Workspace, tag: str, name: str, plan: Plan) -> None:
    if name in plan:
        return
    plan[name] = None
    module = ws.load_module(name)
    before = history.module_at(ws, tag, name)
    if before is None or not module.released:
        return
    dependency = _strongest(_dependency_moves(ws, tag, name, plan))
    moves = [_changelog_move(ws, name), dependency, _sources_move(ws, tag, name)]
    strongest = _strongest(moves)
    expected = str(Version.parse(before.version).bump(strongest.bump))
    if Version.parse(module.version) < Version.parse(expected):
        note = None
        if strongest.bump == dependency.bump and not changelog.unreleased(ws, name):
            note = DEPENDENCY_NOTE.format(dependency.reason)
        plan[name] = Expectation(name, module.version, expected, strongest.reason, note)


def _plan_bundle(ws: Workspace, tag: str, name: str, plan: Plan) -> Iterator[Expectation]:
    before = history.bundle_at(ws, tag, name)
    if before is None:
        return
    bundle = ws.load_bundle(name)
    was = history.members_at(ws, tag, name)
    now = {member: _planned_version(ws, member, plan) for member in ws.members(name)}
    strongest = _strongest(_member_moves(was, now))
    expected = str(Version.parse(before.version).bump(strongest.bump))
    if Version.parse(bundle.version) < Version.parse(expected):
        yield Expectation(name, bundle.version, expected, strongest.reason)


def _planned_version(ws: Workspace, name: str, plan: Plan) -> str:
    expectation = plan.get(name)
    return expectation.expected if expectation else ws.load_module(name).version


def _changelog_move(ws: Workspace, name: str) -> Move:
    notes = changelog.unreleased(ws, name)
    if BREAKING in notes:
        return Move(Bump.MAJOR, "the changelog notes a breaking change")
    if FEATURE in notes:
        return Move(Bump.MINOR, "the changelog notes a new feature")
    if notes:
        return Move(Bump.PATCH, "the changelog notes a change")
    return UNCHANGED


def _dependency_moves(ws: Workspace, tag: str, name: str, plan: Plan) -> Iterator[Move]:
    for dependency in dependencies.strong(ws, name):
        _plan_module(ws, tag, dependency, plan)
        before = history.module_at(ws, tag, dependency)
        if before is not None:
            target = _planned_version(ws, dependency, plan)
            level = Version.parse(before.version).change(Version.parse(target))
            yield Move(level, f"`{dependency}` moved to `v{target}`")


def _sources_move(ws: Workspace, tag: str, name: str) -> Move:
    paths = next(iter(ownership.shipped_changes(ws, tag, name).values()), None)
    return Move(Bump.PATCH, f"{paths[0]} changed") if paths else UNCHANGED


def _member_moves(was: dict[str, str], now: dict[str, str]) -> Iterator[Move]:
    for member in sorted(was.keys() | now.keys()):
        if member not in now:
            yield Move(Bump.MAJOR, f"{member} left the bundle")
        elif member not in was:
            yield Move(Bump.MINOR, f"{member} joined the bundle")
        else:
            level = Version.parse(was[member]).change(Version.parse(now[member]))
            yield Move(level, f"`{member}` moved to `v{now[member]}`")


def _strongest(moves: Iterable[Move]) -> Move:
    return max(moves, key=lambda move: move.bump, default=UNCHANGED)


def _write_version(file: Path, version: str) -> None:
    lines = file.read_text("utf-8").splitlines()
    for index, line in enumerate(lines):
        if line.startswith("version:"):
            lines[index] = f"version: {version}"
            break
    file.write_text("\n".join(lines).rstrip("\n") + "\n", "utf-8", newline="\n")
