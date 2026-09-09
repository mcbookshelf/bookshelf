# 🏅 XP

**`#bs.xp:help`**

Read and modify player XP levels, and set the progress bar by percentage rather than by points.

```{image} /_imgs/modules/xp.png
:class: dark-light p-2
```

---

## Functions

The following functions are available in this module.

---

````{feature} bs.xp:add_levels
```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove experience from the player.
```
````

*Example: add 42 levels*

```mcfunction
# Once (execute on you)
function #bs.xp:add_levels.in {levels:42}

# See the result
# look at your XP bar in survival mode
```

---

````{feature} bs.xp:add_points
```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove experience from the player.
```
````

*Example: add 42 experience points*

```mcfunction
# Once (execute on you)
function #bs.xp:add_points.in {points:42}

# See the result
# look at your XP bar in survival mode
```

---

````{feature} bs.xp:add_progress
```{admonition} How to Remove?
:class: tip

You can use negative numbers to remove experience from the player.
```
````

*Example: add 25% to the fill level of your bar*

```mcfunction
# Once (execute on you)
function #bs.xp:add_progress.in {progress:0.25}

# See the result
# look at your XP bar in survival mode
```

---

```{feature} bs.xp:get_required_points
```

*Example: get the total amount of points required to pass to the next level*

```mcfunction
# Once (execute on you)
function #bs.xp:get_max_points

# See the result (execute on you)
tellraw @a [{"text":"I need a total of "},{"score":{"name":"$xp.get_max_points","objective":"bs.out"}},{"text":" points to pass to the next level"}]
```

---

```{feature} bs.xp:get_remaining_points
```

*Example: get the amount of points needed to pass to the next level*

```mcfunction
# Once (execute on you)
function #bs.xp:get_remaining_points

# See the result (execute on you)
tellraw @a [{"text":"I need "},{"score":{"name":"$xp.get_remaining_points","objective":"bs.out"}},{"text":" points to pass to the next level"}]
```

---

```{feature} bs.xp:get_total_points
```

*Example: get your total amount of points*

```mcfunction
# Once (execute on you)
function #bs.xp:get_total_points

# See the result (execute on you)
tellraw @a [{"text":"I have "},{"score":{"name":"$xp.get_total_points","objective":"bs.out"}},{"text":" total points"}]
```

---

```{feature} bs.xp:get_progress
```

*Example: get the fill percentage of the xp bar*

```mcfunction
# Once (execute on you)
function #bs.xp:get_progress {scale:100}

# See the result
tellraw @a [{"text":"My experience bar is filled at "},{"score":{"name":"$xp.get_progress","objective":"bs.out"}},{"text":"/100"}]
```

---

```{feature} bs.xp:set_levels
```

*Example: set your level to 42*

```mcfunction
# Once (execute on you)
function #bs.xp:set_levels {levels:42}

# See the result
# look at your XP bar in survival mode
```

---

```{feature} bs.xp:set_points
```

*Example: set your points to 42*

```mcfunction
# Once (execute on you)
function #bs.xp:set_points {points:42}

# See the result
# look at your XP bar in survival mode
```

---

```{feature} bs.xp:set_total_points
```

*Example: set your total XP amount to 42*

```mcfunction
# Once (execute on you)
function #bs.xp:set_total_points {points:42}

# See the result
# look at your XP bar in survival mode
```

---

```{feature} bs.xp:set_progress
```

*Example: set your bar at 50%*

```mcfunction
# Once
function #bs.xp:set_progress {progress:0.5}

# See the result
# look at your XP bar in survival mode
```

---

```{include} ../_templates/comments.md
```
