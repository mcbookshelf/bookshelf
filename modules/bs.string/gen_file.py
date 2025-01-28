from beet import Context, Function, FunctionTag

Max = 2**11

def beet_default(ctx: Context) -> None:
    """Generate a help function for the current module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        for a in range(64) :
            generate(a+1,ctx)
        for i in range(11) :
            a = (2**(i+1))
            generate(a,ctx)            
            
def generate(n : int ,ctx: Context) -> None:
    ctx.generate("concat/combine/"+str(n),
            a=n,
            max=Max,
            render=Function(source_path="concat.jinja"),
        )
    ctx.generate("concat/combine/"+str(n)+"c",
            a=n,
            render=Function(source_path="concat_macros.jinja"),
        )
