from __future__ import annotations

from collections.abc import Iterator, Sequence

from pydantic import RootModel


class Collection[T](RootModel[list[T]], Sequence[T]):
    """A typed collection of models that behaves like a Python list."""

    def __getitem__(self, item: int | slice) -> T | Collection[T]:
        """Retrieve an item or slice from the underlying list of models."""
        if isinstance(item, slice):
            return Collection(root=self.root[item])
        return self.root[item]

    def __iter__(self) -> Iterator[T]:
        """Return an iterator over the underlying list of models."""
        return iter(self.root)

    def __len__(self) -> int:
        """Return the number of models in the collection."""
        return len(self.root)

    def __hash__(self) -> int:
        """Hash based on the collection items."""
        return hash(tuple(self.root))
