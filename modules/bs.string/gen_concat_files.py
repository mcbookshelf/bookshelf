from beet import Context, Function

ITERATION = 8
MAX = 2**ITERATION

def beet_default(ctx: Context) -> None:
    """Generate a help function for the current module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        for a in range(64) :
            gen_concat_functions(a+1,ctx)
        for i in range(ITERATION) :
            a = (2**(i+1))
            gen_concat_functions(a,ctx)

def gen_concat_functions(n : int ,ctx: Context) -> None:
    ctx.generate(f"concat/combine/{n}",
            a=n,
            max=MAX,
            render=Function(source_path="concat.jinja"),
        )
    ctx.generate(f"concat/combine/{n}c",
            a=n,
            render=Function(source_path="concat_macros.jinja"),
        )
