import shutil


def pdm_build_initialize(context):
    context.ensure_build_dir()
    shutil.copytree(
        "./modules",
        f"{context.build_dir}/bookshelf/modules",
    )
