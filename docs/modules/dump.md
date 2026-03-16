# 🔬 Dump

**`#bs.dump:help`**

The dump module provides mechanisms for printing the state of any "variables".

```{warning}
Since version 26.1, Minecraft now pretty-prints NBT data in text components. As a result, this module has become less useful. The update also introduced new constraints that broke several features.

The module is still functional, however, when concatenation is required, expand and copy operations are not available at all. A future rework is planned to improve usability and reduce complexity. For now, the priority has been to keep the module operational.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Dump Var

```{function} #bs.dump:var {var:<values>}

Dump the content of given variables to the chat.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` {nbt}`list` {nbt}`string` **var**: Can be any structured data. The only requirement is that all values must be valid string paths to data or scores:
      - [data]: `<entity|block|storage> <target> [<path>] [<depth>]`
      - [score]: `<target> <objective>`
  :::
```

*Example: View position scores as an array:*

```{code-block} mcfunction
:force:
function #bs.position:get_pos {scale:1}
function #bs.dump:var {var: ["@s bs.pos.x", "@s bs.pos.y", "@s bs.pos.z"]}
```

![](/_imgs/modules/dump/example-1.png)

*Example: View an undefined score and the player recipe book (with a depth of 1):*

```mcfunction
function #bs.dump:var {var: {_: "foo bar", recipes: "entity @s recipeBook 1"}}
```

![](/_imgs/modules/dump/example-2.png)

`````{important}
Due to the implementation and its inherent constraints, it is necessary to escape values at the top level.

```mcfunction
function #bs.dump:var {var: '"storage bs:const"'}
```
`````

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
