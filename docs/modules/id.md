# 🏷️ ID

**`#bs.id:help`**

Manage entity IDs, essential in scenarios like shooting games where you need to track who is targeting whom.

```{epigraph}
"We know what we are, but know not what we may be."

-- William Shakespeare
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Give Simple Unique ID

```{function} #bs.id:give_suid

Give a unique `bs.id` score to each entity.

:Inputs:
  **Execution `as <entities>`**: Entities to assign an ID to.

:Outputs:
  **Score `@s bs.id`**: Generated simple unique id.
```

*Give an ID to all players:*
```mcfunction
# Give an id to all players who don’t already have one
execute as @a[predicate=!bs.id:has_suid] run function #bs.id:give_suid

# See the result
scoreboard objective setdisplay sidebar bs.id
```

> **Credits**: Aksiome, KubbyDev

---

### Give Chain Unique ID

```{function} #bs.id:give_cuid

Give a unique `bs.cid` score to each entity.

:Inputs:
  **Execution `as <entities>`**: Entities to assign an ID to.

:Outputs:
  **Score `@s bs.cid`**: Generated chain unique id.
```

```{admonition} How it works?
:class: info

The chain ID is similar to the simple ID. However with chain IDs, you can use the function `#bs.id:update_cuids` to make sure there are no gaps in the ID sequence, thus creating a continuous chain.
```

*Give an ID to all players:*
```mcfunction
# Give an id to all players who don’t have one
execute as @a[predicate=!bs.id:has_cuid] run function #bs.id:give_cuid

# See the result
scoreboard objective setdisplay sidebar bs.cid
```

> **Credits**: Aksiome, KubbyDev

---

### Update Chain Unique ID

```{function} #bs.id:update_cuids

Update all entities CUIDs to ensure the chain is continuous.
```

*Ensure the chain is free of gaps and duplicates:*

```mcfunction
function #bs.id:update_cuids

# See the result
scoreboard objective setdisplay sidebar bs.cid
```

> **Credits**: Aksiome, KubbyDev

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Check Simple Unique ID

::::{tab-set}
:::{tab-item} Has

```{function} bs.id:has_suid

Determine if an entity has a `bs.id` score.
```

*Give an suid to all entities that aren't identified by a `bs.id` score:*

```mcfunction
execute as @e[predicate=!bs.id:has_suid] run function #bs.id:give_suid
```

:::
:::{tab-item} Equal

```{function} bs.id:suid_equal

Find an entity that has the same `bs.id` as the input value.

:Inputs:
  **Score `$id.suid bs.in`**: Value to check against.
```

*Find the entity that has a `bs.id` equal to 1:*

```mcfunction
scoreboard players set $id.suid bs.in 1
execute as @e[predicate=bs.id:suid_equal,limit=1] run say I'm the one
```

:::
:::{tab-item} Lower

```{function} bs.id:suid_lower

Filter entities that have a `bs.id` less than or equal to the input value.

:Inputs:
  **Score `$id.suid bs.in`**: Value to check against.
```

*Filter entities that have a `bs.id` less than or equal to 17:*

```mcfunction
scoreboard players set $id.suid bs.in 17
execute as @e[predicate=bs.id:suid_lower] run say I'm a minor
```

:::
:::{tab-item} Upper

```{function} bs.id:suid_upper

Filter entities that have a `bs.id` greater than or equal to the input value.

:Inputs:
  **Score `$id.suid bs.in`**: Value to check against.
```

*Filter entities that have a `bs.id` greater than or equal to 18:*

```mcfunction
scoreboard players set $id.suid bs.in 18
execute as @e[predicate=bs.id:suid_upper] run say I'm an adult
```

:::
:::{tab-item} Match

```{function} bs.id:suid_match

Filter entities that have a `bs.id` between the given values.

:Inputs:
  **Score `$id.suid.min bs.in`**: Min value to check against.

  **Score `$id.suid.max bs.in`**: Max value to check against.
```

*Filter entities that have a `bs.id` between 2 and 4:*

```mcfunction
scoreboard players set $id.suid.min bs.in 2
scoreboard players set $id.suid.max bs.in 4
execute as @e[predicate=bs.id:suid_match,limit=1] run say In range
```

:::
::::

> **Credits**: Aksiome

---

### Check Chain Unique ID

::::{tab-set}
:::{tab-item} Has

```{function} bs.id:has_cuid

Determine if an entity has a `bs.cid` score.
```

*Give an cuid to all entities that aren't identified by a `bs.cid` score:*

```mcfunction
execute as @e[predicate=!bs.id:has_cuid] run function #bs.id:give_cuid
```

:::
:::{tab-item} Equal

```{function} bs.id:cuid_equal

Find an entity that has the same `bs.cid` as the input value.

:Inputs:
  **Score `$id.cuid bs.in`**: Value to check against.
```

*Find the entity that has a `bs.cid` equal to 1:*

```mcfunction
scoreboard players set $id.cuid bs.in 1
execute as @e[predicate=bs.id:cuid_equal,limit=1] run say I'm the one
```

:::
:::{tab-item} Lower

```{function} bs.id:cuid_lower

Filter entities that have a `bs.cid` less than or equal to the input value.

:Inputs:
  **Score `$id.cuid bs.in`**: Value to check against.
```

*Filter entities that have a `bs.cid` less than or equal to 17:*

```mcfunction
scoreboard players set $id.cuid bs.in 17
execute as @e[predicate=bs.id:cuid_lower] run say I'm a minor
```

:::
:::{tab-item} Upper

```{function} bs.id:cuid_upper

Filter entities that have a `bs.cid` greater than or equal to the input value.

:Inputs:
  **Score `$id.cuid bs.in`**: Value to check against.
```

*Filter entities that have a `bs.cid` greater than or equal to 18:*

```mcfunction
scoreboard players set $id.cuid bs.in 18
execute as @e[predicate=bs.id:cuid_upper] run say I'm an adult
```

:::
:::{tab-item} Match

```{function} bs.id:cuid_match

Filter entities that have a `bs.cid` between the given values.

:Inputs:
  **Score `$id.cuid.min bs.in`**: Min value to check against.

  **Score `$id.cuid.max bs.in`**: Max value to check against.
```

*Filter entities that have a `bs.cid` between 2 and 4:*

```mcfunction
scoreboard players set $id.cuid.min bs.in 2
scoreboard players set $id.cuid.max bs.in 4
execute as @e[predicate=bs.id:cuid_match,limit=1] run say In range
```

:::
::::

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
