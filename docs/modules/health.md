# ❤️ Health

**`#bs.health:help`**

Read and modify player health, and give entities a lifetime.

```{pull-quote}
"He who has a why to live can bear almost any how."

-- Friedrich Nietzsche
```

```{admonition} About NBTs
:class: warning

Do not rely on NBTs to read health while using this module: get it with `get_health`, rather than with `data get`. NBTs may lag behind the actual values, which is a limitation this module works around.
```

```{admonition} Effects Incompatibility
:class: warning

Healing is applied with the `instant_health` effect, which also forces the health to update. Amplifiers above 28 may cause issues, and a pending healing command takes precedence over the effect for the current tick, potentially overriding it.
```

---

## Functions

The following functions are available in this module.

---

### Add health

```{feature} bs.health:add_health
```

*Example: damage yourself by 5 points*

```mcfunction
# Once (execute on you)
function #bs.health:add_health.in {points:-5.0}

# See the result
# look at your hearts in survival mode
```

---

### Add max health

```{feature} bs.health:add_max_health
```

*Example: gain 5 max health points*

```mcfunction
# Once (execute on you)
function #bs.health:add_max_health.in {points:5.0}

# See the result
# look at your hearts in survival mode
```

---

### Get health

```{feature} bs.health:get_health
```

*Example: get your health*

```mcfunction
# Once (execute on you)
function #bs.health:get_health

# See the result
tellraw @a [{"text":"I have "},{"nbt":"out","storage":"bs.health:get_health"},{"text":" health points"}]
```

---

### Get max health

```{feature} bs.health:get_max_health
```

*Example: get your base max health*

```mcfunction
# Once (execute on you)
function #bs.health:get_max_health

# See the result
tellraw @a [{"text":"I can have up to "},{"nbt":"out","storage":"bs.health:get_max_health"},{"text":" health points"}]
```

---

### Set health

```{feature} bs.health:set_health
```

*Example: set your health to 10 points*

```mcfunction
# Once (execute on you)
function #bs.health:set_health.in {points:10.0}

# See the result
# look at your hearts in survival mode
```

---

### Set max health

```{feature} bs.health:set_max_health
```

*Example: set your base max health to 10 points*

```mcfunction
# Once (execute on you)
function #bs.health:set_max_health.in {points:10.0}

# See the result
# look at your hearts in survival mode
```

---

### Set time to live

```{feature} bs.health:set_ttl
```

*Example: give creepers 10 seconds to live*

```mcfunction
# Once
execute as @e[type=minecraft:creeper] run function #bs.health:set_ttl.in {time:"10s"}

# See the result
# wait 10 seconds and look for the creepers
```

---

### Set time to live on death

```{feature} bs.health:set_ttl_on_death
```

*Example: make creepers explode into particles at the end of their life*

```mcfunction
# Once
execute as @e[type=minecraft:creeper] run function #bs.health:set_ttl.in {time:200}
execute as @e[type=minecraft:creeper] run function #bs.health:set_ttl_on_death.in {run:"execute at @s run particle minecraft:explosion_emitter ~ ~ ~"}

# See the result
# wait 10 seconds and look for the particles
```

---

```{include} ../_templates/comments.md
```
