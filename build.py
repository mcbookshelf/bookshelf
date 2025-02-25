import shutil


def pdm_build_initialize(context) -> None: # noqa: ANN001
    """Add modules to the bookshelf directory when building project."""
    context.ensure_build_dir()
    shutil.copytree(
        "./modules",
        f"{context.build_dir}/bookshelf/modules",
    )
