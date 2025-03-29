# 🏅 XP

**`#bs.xp:help`**

Efficiently manage the experience points and levels of players.

```{image} /_imgs/modules/xp.png
:class: dark-light p-2
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Add / Remove

:::::{tab-set}
::::{tab-item} Levels

```{function} #bs.xp:add_levels {levels:<value>}

Add levels to the player.

:Inputs:
  **Execution `as <players>`**: Players to add levels to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **levels**: Amount of levels to add.
  :::

:Outputs:
  **State**: Players' XP is updated.
```

*Example: Add 42 levels:*

```mcfunction
# Once (execute on you)
function #bs.xp:add_levels {levels:42}

# See the result
# look at your XP bar in survival mode
```

::::
::::{tab-item} Points

```{function} #bs.xp:add_points {points:<value>}

Add experience points to the player.

:Inputs:
  **Execution `as <players>`**: Players to add points to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **points**: Amount of points to add.
  :::

:Outputs:
  **State**: Players' XP is updated.
```

*Example: Add 42 experience points:*

```mcfunction
# Once (execute on you)
function #bs.xp:add_points {points:42}

# See the result
# look at your XP bar in survival mode
```

::::
::::{tab-item} Progress Bar

```{function} #bs.xp:add_progress {progress:<value>}

Fill the XP bar partially.

:Inputs:
  **Execution `as <players>`**: Players to fill the XP bar.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`double` **progress**: Progress to add to the bar (in range [-1,1]).
  :::

:Outputs:
  **State**: Players' XP is updated.
```

*Example: Add 25% to the fill level of your bar:*

```mcfunction
# Once (execute on you)
function #bs.xp:add_progress {progress:0.25}

# See the result
# look at your XP bar in survival mode
```

::::
:::::

```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove experience from the player.

```

> **Credits**: Aksiome, Leirof

---

### Get

:::::{tab-set}
::::{tab-item} Max Points

```{function} #bs.xp:get_max_points

Get the total amount of points required to reach the next level.

:Inputs:
  **Execution `as <players>`**: Players from whom you want to get the max amount of points.

:Outputs:
  **Return | Score `$xp.get_max_points bs.out`**: Total amount of points required for the next level.
```

*Example: Get the total amount of points required to pass to the next level:*

```mcfunction
# Once (execute on you)
function #bs.xp:get_max_points

# See the result (execute on you)
tellraw @a [{"text":"I need a total of "},{"score":{"name":"$xp.get_max_points","objective":"bs.out"}},{"text":" points to pass to the next level"}]
```

::::
::::{tab-item} Remaining Points

```{function} #bs.xp:get_remaining_points

Get the remaining amount of points needed to reach the next level.

:Inputs:
  **Execution `as <players>`**: Players from whom you want to get the remaining points.

:Outputs:
  **Return | Score `$xp.get_remaining_points bs.out`**: Points needed for the next level.
```

*Example: Get the amount of points needed to pass to the next level:*

```mcfunction
# Once (execute on you)
function #bs.xp:get_remaining_points

# See the result (execute on you)
tellraw @a [{"text":"I need "},{"score":{"name":"$xp.get_remaining_points","objective":"bs.out"}},{"text":" points to pass to the next level"}]
```

::::
::::{tab-item} Total Points

```{function} #bs.xp:get_total_points

Get the sum of all points a player has gathered.

:Inputs:
  **Execution `as <players>`**: Players from whom you want to get the total amount of points.

:Outputs:
  **Return | Score `$xp.get_total_points bs.out`**: Total amount of points.
```

*Example: Get your total amount of points:*

```mcfunction
# Once (execute on you)
function #bs.xp:get_total_points

# See the result (execute on you)
tellraw @a [{"text":"I have "},{"score":{"name":"$xp.get_total_points","objective":"bs.out"}},{"text":" total points"}]
```

::::
::::{tab-item} Progress Bar

```{function} #bs.xp:get_progress {scale:<scaling>}

Get the fill progress of the XP bar.

:Inputs:
  **Execution `as <players>`**: Players from whom you want to get the bar progress.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Return | Score `$xp.get_progress bs.out`**: Fill level of the XP bar after scaling.
```

*Example: Get the fill percentage of the xp bar:*

```mcfunction
# Once (execute on you)
function #bs.xp:get_progress {scale:100}

# See the result
tellraw @a [{"text":"My experience bar is filled at "},{"score":{"name":"$xp.get_progress","objective":"bs.out"}},{"text":"/100"}]
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

### Set

:::::{tab-set}
::::{tab-item} Levels

```{function} #bs.xp:set_levels {levels:<value>}

Set players levels.

:Inputs:
  **Execution `as <players>`**: Players to set levels to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **levels**: Amount of levels to set.
  :::

:Outputs:
  **State**: Players XP is updated.
```

*Example: Set your level to 42:*

```mcfunction
# Once (execute on you)
function #bs.xp:set_levels {levels:42}

# See the result
# look at your XP bar in survival mode
```

::::
::::{tab-item} Points

```{function} #bs.xp:set_points {points:<value>}

Set players experience points.

:Inputs:
  **Execution `as <players>`**: Players to set points to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **points**: Amount of experience points to set.
  :::

:Outputs:
  **State**: Players XP is updated.
```

*Example: Set your points to 42:*

```mcfunction
# Once (execute on you)
function #bs.xp:set_points {points:42}

# See the result
# look at your XP bar in survival mode
```

::::
::::{tab-item} Total Points

```{function} #bs.xp:set_total_points {points:<value>}

Set players total experience points.

:Inputs:
  **Execution `as <players>`**: Players you want to set the total XP.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **points**: Amount of total experience points to set.
  :::

:Outputs:
  **State**: Players XP is updated.
```

*Example: Set your total XP amount to 42:*

```mcfunction
# Once (execute on you)
function #bs.xp:set_total_points {points:42}

# See the result
# look at your XP bar in survival mode
```

::::
::::{tab-item} Progress Bar

```{function} #bs.xp:set_progress {progress:<value>}

Fill the XP bar partially.

:Inputs:
  **Execution `as <players>`**: Players to fill the XP bar.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`double` **progress**: Progress to set on the bar (in range [-1,1]).
  :::

:Outputs:
  **State**: Players XP is updated.
```

*Example: Fill your bar at 50%:*

```mcfunction
# Once
function #bs.xp:set_progress {progress:0.5}

# See the result
# look at your XP bar in survival mode
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

```{include} ../_templates/comments.md
```
