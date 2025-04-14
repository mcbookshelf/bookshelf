# ❤️ Health

**`#bs.health:help`**

Efficiently manage the lifecycle and vital aspects of an entity.

```{epigraph}
"He who has a why to live can bear almost any how."

-- Friedrich Nietzsche
```

```{admonition} About NBTs
:class: warning

When using this module, do not rely on NBTs to retrieve health information. Instead, use `get_health` to get the player's health and `get_max_health_total` for the max health, rather than using `attribute @s minecraft:max_health get`. NBTs may not always reflect the actual values, and this approach was chosen to bypass certain limitations.
```

```{admonition} Effects Incompatibility
:class: warning

This system uses the `instant_health` effect to heal the player and force an update to their health. Using amplifier values higher than 28 may cause issues. Additionally, any pending healing command will take precedence over the effect for the current tick, potentially overriding it.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Add / Remove

:::::{tab-set}
::::{tab-item} Health

```{function} #bs.health:add_health {points:<value>}

Add or remove health points from players.

:Inputs:
  **Execution `as <players>`**: Players whose health will be updated.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **points**: Health points to add to players.
  :::

:Outputs:
  **State**: Health is scheduled for update.
```

*Example: Heal yourself by 5 HP:*

```mcfunction
# Once (execute on you)
function #bs.health:add_health {points:5.0}
```

```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove health points from the player.
```

::::
::::{tab-item} Max Health

```{function} #bs.health:add_max_health {points:<value>}

Add or remove base maximum health points from players.

:Inputs:
  **Execution `as <players>`**: Players whose max health will be updated.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **points**: Max health points to add to players.
  :::

:Outputs:
  **State**: Max health is scheduled for update.
```

*Example: Increase your max HP by 5:*

```mcfunction
# Add 5 maximum health points to the executing player
function #bs.health:add_max_health {points:5.0}
```

```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove max health from the player.
```

::::
:::::

> **Credits**: Aksiome

---

### Get

:::::{tab-set}
::::{tab-item} Health

```{function} #bs.health:get_health {scale:<scaling>}

Get a player's health points.

:Inputs:
  **Execution `as <players>`**: Players from which you want to get health points.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's returned value.
  :::

:Outputs:
  **Return | Storage `bs:out health.get_health`**: {nbt}`double` Player's health points.
```

*Example: Get your current HP (scaled by 1000):*

```mcfunction
# Get and display the current health of the executing player
function #bs.health:get_health {scale:1000}
```

::::
::::{tab-item} Max Health

```{function} #bs.health:get_max_health {scale:<scaling>}

Get a player's base maximum health points.

:Inputs:
  **Execution `as <players>`**: Players from which you want to get max health points.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's returned value.
  :::

:Outputs:
  **Return | Storage `bs:out health.get_max_health`**: {nbt}`double` Player's max health points.
```

*Example: Get your maximum HP (scaled by 1000):*

```mcfunction
# See the returned value (execute on you)
function #bs.health:get_max_health {scale:1000}
```

::::
:::::

> **Credits**: Aksiome

---

### Set

:::::{tab-set}
::::{tab-item} Health

```{function} #bs.health:set_health {points:<value>}

Set players' health points.

:Inputs:
  **Execution `as <players>`**: Players whose health will be updated.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **points**: Health points.
  :::

:Outputs:
  **State**: Health is scheduled for update.
```

*Example: Set your HP to 10:*

```mcfunction
# Once (execute on you)
function #bs.health:set_health {points:5.0}
```

::::
::::{tab-item} Max Health

```{function} #bs.health:set_max_health {points:<value>}

Set players' base maximum health points.

:Inputs:
  **Execution `as <players>`**: Players whose max health will be updated.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **points**: Max health points.
  :::

:Outputs:
  **State**: Max health is scheduled for update.
```

*Example: Set your max HP to 10:*

```mcfunction
# Once (execute on you)
function #bs.health:set_max_health {points:5.0}
```

::::
:::::

> **Credits**: Aksiome

---

### Time to Live

```{function} #bs.health:time_to_live {with:{}}

Set the lifetime of entities.

:Inputs:
  **Execution `as <entities>`**: Entities to add a lifetime to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Lifetime data.
      - {nbt}`int` **time**: Time to live. In ticks by default if unit is not defined.
      - {nbt}`string` **unit**: Unit of the specified time (tick, second, minute, hour, t, s, m, h).
      - {nbt}`string` **on_death**: Command that will be run as the entity on its death.
  :::

:Outputs:
  **State**: The entity now has a finite lifetime.
```

*Example: Give creepers a 10-second lifetime:*

```mcfunction
# Set a 10-second lifetime for all creepers
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:10,unit:"s"}}
```

*Example: Give an explosion effect to creepers at the end of their life:*

```mcfunction
# Set a lifetime with explosion effect for all creepers
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:10,on_death:"execute at @s run particle minecraft:explosion_emitter ~ ~ ~"}}
```

*Example: Update the on_death callback at any given time:*

```mcfunction
# Set initial lifetime with explosion effect
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:100,on_death:"execute at @s run particle minecraft:explosion_emitter ~ ~ ~"}}

# At any time before the entity's death
execute as @e[type=minecraft:creeper,limit=1] run function #bs.health:time_to_live {with:{on_death:"say GOTCHA"}}
```

> **Credits**: Aksiome, Leirof

---

```{include} ../_templates/comments.md
```
