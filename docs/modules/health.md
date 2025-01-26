# ❤️ Health

**`#bs.health:help`**

Efficiently manage the lifecycle and vital aspects of an entity.

```{epigraph}
"He who has a why to live can bear almost any how."

-- Friedrich Nietzsche
```

```{admonition} About NBTs
:class: warning

When using the module, you cannot rely on NBTs to get health information. Use the `get_health` and `get_max_health` functions instead. This is because NBTs may not consistently reflect actual values. This choice was made to enhance performance, reliability, and to work around some limitations.
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

*Heal yourself by 5 HP:*
```mcfunction
# Once (execute on you)
function #bs.health:add_health {points:5.0}
```

```{admonition} How to remove?
:class: tip

You can use negative numbers to remove health points from the player.
```

::::
::::{tab-item} Max Health

```{function} #bs.health:add_max_health {points:<value>}

Add or remove maximum health points from players.

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

*Increase your max HP by 5:*
```mcfunction
# Once (execute on you)
function #bs.health:add_max_health {points:5.0}
```

```{admonition} How to remove?
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
    - {nbt}`number` **scale**: Scalar for the function’s returned value.
  :::

:Outputs:
  **Return | Storage `bs:out health.get_health`**: {nbt}`double` Player's health points.
```

*Get your current HP (scaled by 1000):*
```mcfunction
# See the returned value (execute on you)
function #bs.health:get_health {scale:1000}
```

::::
::::{tab-item} Max Health

```{function} #bs.health:get_max_health {scale:<scaling>}

Get a player's maximum health points.

:Inputs:
  **Execution `as <players>`**: Players from which you want to get max health points.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function’s returned value.
  :::

:Outputs:
  **Return | Storage `bs:out health.get_max_health`**: {nbt}`double` Player's max health points.
```

*Get your maximum HP (scaled by 1000):*
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

Set players health points.

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

*Set your HP to 10:*
```mcfunction
# Once (execute on you)
function #bs.health:set_health {points:5.0}
```

::::
::::{tab-item} Max Health

```{function} #bs.health:set_max_health {points:<value>}

Set players maximum health points.

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

*Set your max HP to 10:*
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

Set the life time of entities.

:Inputs:
  **Execution `as <entities>`**: Entities to add a life time to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Life time data.
      - {nbt}`int` **time**: Time to live. In ticks by default if unit is not defined.
      - {nbt}`string` **unit**: Unit of the specified time (tick, second, minute, hour, t, s, m, h).
      - {nbt}`string` **on_death**: Command that will be run as the entity on its death.
  :::

:Outputs:
  **State**: The entity has now a finite life time.
```

*Give creepers a 10 seconds life time:*

```mcfunction
# Once
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:10,unit:"s"}}
```

*Give an explosion effect to creepers at the end of their life:*

```mcfunction
# Once
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:10,on_death:"execute at @s run particle minecraft:explosion_emitter ~ ~ ~"}}
```

*Update the on_death callback at any given time:*

```mcfunction
# Once
execute as @e[type=minecraft:creeper] run function #bs.health:time_to_live {with:{time:100,on_death:"execute at @s run particle minecraft:explosion_emitter ~ ~ ~"}}

# At any time before the entity's death
execute as @e[type=minecraft:creeper,limit=1] run function #bs.health:time_to_live {with:{on_death:"say GOTCHA"}}
```

> **Credits**: Aksiome, Leirof

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
