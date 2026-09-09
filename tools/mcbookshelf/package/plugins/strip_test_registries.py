from collections.abc import Generator

from beet import Context


def beet_default(ctx: Context) -> Generator[None]:
    yield

    ctx.data.test_environments.clear()
    ctx.data.test_instances.clear()
