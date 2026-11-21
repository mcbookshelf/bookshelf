from collections.abc import Callable
from dataclasses import dataclass
from typing import Any

from beet import Cache

from mcbookshelf import constants
from mcbookshelf.minecraft.condition import Condition, cube_size
from mcbookshelf.minecraft.data import fetch
from mcbookshelf.minecraft.math import Expression, btree, const, first

type Size = tuple[float, float]

FLAGS = ("living", "pickable", "pushable", "collidable", "attached")
NATURAL_CUBE_SIZES = frozenset({1, 2, 4})
MAX_CUBE_SIZE = 127


@dataclass(frozen=True, slots=True)
class Variant:

    size: Size
    traits: tuple[tuple[str, Any], ...]

    def get(self, key: str) -> Any:  # noqa: ANN401
        return dict(self.traits).get(key)


@dataclass(frozen=True, slots=True)
class Entity:

    id: str
    variants: tuple[Variant, ...]
    living: bool = False
    pickable: bool = False
    pushable: bool = False
    collidable: bool = False
    attached: bool = False

    def ages(self) -> tuple[Size, Size]:
        """The adult and baby sizes, both the adult one when there is no baby form."""
        by_age = self.by("baby")
        adult = by_age.get(False) or by_age[None]
        return adult, by_age.get(True, adult)

    def by(self, key: str) -> dict[Any, Size]:
        """The size for each value of `key`, None where the data does not say."""
        if not self.variants:
            raise ValueError("no size in the data")
        sizes = {}
        for variant in self.variants:
            sizes.setdefault(variant.get(key), set()).add(variant.size)
        if any(len(found) > 1 for found in sizes.values()):
            traits = sorted({trait for variant in self.variants for trait, _ in variant.traits})
            others = [t for t in traits if t != key and len({v.get(t) for v in self.variants}) > 1]
            raise ValueError(f"the size depends on {', '.join(others)}")
        return {value: found.pop() for value, found in sizes.items()}


def get_entities(
    cache: Cache,
    version: str = constants.GAME_VERSION,
) -> dict[str, Entity]:
    return {
        entity_id: Entity(
            entity_id,
            _variants(data.get("dimensions", ())),
            **{field: data.get(field, False) for field in FLAGS},
        )
        for entity_id, data in fetch(cache, "entities", version).items()
    }


def by_trait(
    entity: Entity,
    key: str,
    test: Callable[[Any], Condition],
    value: Callable[[Size], Expression],
) -> Expression:
    """The value of the size for each value of a trait, testing all of them but the last."""
    sizes = entity.by(key)
    *others, last = sorted(sizes)
    return first(
        *((test(trait), value(sizes[trait])) for trait in others),
        default=value(sizes[last]),
    )


def cube_size_provider() -> Expression:
    """The size of a slime, magma cube or sulfur cube, with the natural sizes tested first."""
    weight = lambda n: 1000 if n in NATURAL_CUBE_SIZES else 1  # noqa: E731
    return btree(range(1, MAX_CUBE_SIZE + 1), const, lambda half: cube_size(half[-1]), weight)


def _variants(dimensions: list[dict[str, Any]]) -> tuple[Variant, ...]:
    variants = []
    for d in dimensions:
        size = (d["width"], d["height"])
        traits = [(k, v) for k, v in d.items() if k not in {"width", "height", "poses"}]
        if "poses" not in d:
            variants.append(Variant(size, tuple(sorted(traits))))
        variants.extend(
            Variant(size, tuple(sorted([*traits, ("pose", pose)])))
            for pose in d.get("poses", ())
            if pose != "sleeping"
        )
    return tuple(variants)
