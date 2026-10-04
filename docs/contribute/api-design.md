# 🧠 API design

All features take inputs and return outputs in the same way. A user who knows one module knows them all. You declare everything on this page in the [metadata](project:metadata.md).

---

## Inputs

A feature reads its inputs from a storage that has its name: `<module>:<feature>`, at the path `in`. This applies to every type of feature, such as functions, predicates, and number providers.

```mcfunction
data modify storage bs.bitwise:and in set value {a:-9,b:57}
execute store result score #r bs.ctx run compute default integer bs.bitwise:and
```

- Use the executor, position, rotation, and dimension as inputs when you can. `execute as <entity> at <position>` is simpler for users than an argument.
- Don't change the inputs.
- Keep the arguments few and required. If a feature does two things, split it into two features.
- When an argument is a command, name it `run` and make it a string.

---

## Outputs

A feature returns its outputs in one or more of these ways. Don't use scores as outputs.

:::{list-table}
*   - **`storage`**
    - Data in the storage `<module>:<feature>`, at the path `out`

      *Example: `data get storage bs.xp:get_progress out`*
*   - **`result`**
    - The number that the feature returns

      *Example: `execute store result score @s my_objective run function #bs.hitbox:get_block/collision`*
*   - **`success`**
    - The feature succeeds or fails

      *Example: `execute if function #bs.hitbox:is_in_block run say Inside`*
*   - **`state`**
    - A change in the world, such as a new block or a changed entity
:::

If a function declares a `success` or a `result`, end every path with a `return`:

- Use `return fail` when the function fails. `return 0` is a success that returns 0.
- A function that ends without a `return` gives no result.

---

(contribute-calling-a-feature)=
## Functions

Users call a function feature through its function tag:

```mcfunction
data modify storage bs.health:set_health in set value {points:10}
function #bs.health:set_health
```

### Macro call

If you declare the function with `input arguments`, users can also call it with a macro. They use the `.in` tag. Both calls do the same thing:

```mcfunction
function #bs.health:set_health.in {points:10}
```

Optional arguments go in a `with` argument:

```mcfunction
function #bs.<module>:<feature>.in {block:"minecraft:stone",with:{mode:"keep"}}
```

The build generates the `__macro__` function behind the `.in` tag. Write it yourself when a macro is faster than a storage read. Then make `__main__` call it:

```{code-block} mcfunction
:caption: add_levels/\_\_macro\_\_.mcfunction
$xp add @s $(levels) levels
```

```{code-block} mcfunction
:caption: add_levels/\_\_main\_\_.mcfunction
function bs.xp:add_levels/__macro__ with storage bs.xp:add_levels in
```
