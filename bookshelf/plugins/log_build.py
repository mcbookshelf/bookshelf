from beet import Context

from bookshelf.logger import get_step_logger


def beet_default(ctx: Context) -> None:
    """Log the module build process with a debug message."""
    get_step_logger().debug("Build module '%s'", ctx.directory.name)
