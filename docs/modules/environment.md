# ⛰️ Environment

**`#bs.environment:help`**

Comprehensive information and tools related to weather and biome properties.

```{image} /_imgs/modules/environment.png
:width: 100%
:class: dark_light
```

```{epigraph}
"The most dangerous worldview is the worldview of those who have not viewed the world."

-- Alexander von Humboldt
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Get Biome

```{function} #bs.environment:get_biome

Get biome data at the execution position of the function.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position from which you want to get biome data.

:Outputs:
  **Storage `bs:out environment.get_biome`**:
  :::{treeview}
  - {nbt}`compound` Biome data
    - {nbt}`string` **type**: String representation of the biome ID (e.g., `minecraft:plains`).
    - {nbt}`double` **temperature**: The base temperature of the biome.
    - {nbt}`bool` **has_precipitation**: Whether the biome has precipitation or not.
  :::
```

*Example: Get biome data at the current location:*

```mcfunction
# Once
function #bs.environment:get_biome
data get storage bs:out environment.get_biome
```

> **Credits**: Aksiome

---

### Get Temperature

```{function} #bs.environment:get_temperature {scale:<scaling>}

Get the temperature at the execution position of the function, taking the altitude into account.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position from which you want to get the temperature.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Return | Score `$environment.get_temperature bs.out`**: Temperature at the given position.
```

*Example: Get the temperature at the current altitude:*

```mcfunction
# Once
function #bs.environment:get_temperature {scale:1000}
```

> **Credits**: Aksiome, theogiraudet

---

### Celestial Movement

:::::{tab-set}
::::{tab-item} Get Sun Angle

```{function} #bs.environment:get_sun_angle

Get the sun's angle on the Y axis relative to the horizon, in degrees.
Also works when the doDaylightCycle is set to false.

:Outputs:
  **Return | Score `$environment.get_sun_angle bs.out`**: Sun's angle in degrees (scaled by 1000).
```

*Example: Get the sun's current angle:*

```mcfunction
# Once
function #bs.environment:get_sun_angle
tellraw @a [{"text":"Sun angle: "},{"score":{"name":"$environment.get_sun_angle","objective":"bs.out"}},{"text":"°"}]
```

::::
::::{tab-item} Get Moon Angle

```{function} #bs.environment:get_moon_angle

Get the moon's angle on the Y axis relative to the horizon, in degrees.
Also works when the doDaylightCycle is set to false.

:Outputs:
  **Return | Score `$environment.get_moon_angle bs.out`**: Moon's angle in degrees (scaled by 1000).
```

*Example: Get the moon's current angle:*

```mcfunction
# Once
function #bs.environment:get_moon_angle
tellraw @a [{"text":"Moon angle: "},{"score":{"name":"$environment.get_moon_angle","objective":"bs.out"}},{"text":"°"}]
```

::::
::::{tab-item} Look at Sun

```{function} #bs.environment:look_at_sun

Orient the executing entity to look at the sun.

:Inputs:
  **Execution `as <entity>`**: The entity to orient.

:Outputs:
  **State**: The entity's rotation is modified to face the sun.
```

*Example: Make the current entity look at the sun:*

```mcfunction
# Once
function #bs.environment:look_at_sun
```

::::
::::{tab-item} Look at Moon

```{function} #bs.environment:look_at_moon

Orient the executing entity to look at the moon.

:Inputs:
  **Execution `as <entity>`**: The entity to orient.

:Outputs:
  **State**: The entity's rotation is modified to face the moon.
```

*Example: Make the current entity look at the moon:*

```mcfunction
# Once
function #bs.environment:look_at_moon
```

::::
:::::

> **Credits**: theogiraudet

---

### Get Moon Phase

```{function} #bs.environment:get_moon_phase

Get the current moon phase as a string identifier.

:Outputs:
  **Storage `bs:out environment.get_moon_phase`**: {nbt}`string` Moon phase identifier.
```

*Example: Get the current moon phase:*

```mcfunction
# Once
function #bs.environment:get_moon_phase
data get storage bs:out environment.get_moon_phase
```

```{admonition} Moon Phase Values
:class: note

The function returns one of the following string values:
- `"full_moon"`
- `"waning_gibbous"`
- `"third_quarter"`
- `"waning_crescent"`
- `"new_moon"`
- `"waxing_crescent"`
- `"first_quarter"`
- `"waxing_gibbous"`

The moon phase cycle follows Minecraft's 8-day lunar cycle.
```

> **Credits**: theogiraudet

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Can It Rain?

**`bs.environment:can_rain`**

Determine if it can rain or not.

> **Credits**: Aksiome

---

### Can It Snow?

**`bs.environment:can_snow`**

Determine if it can snow or not.

> **Credits**: Aksiome

---

### Can It Rain or Snow?

**`bs.environment:has_precipitation`**

Determine if the biome has precipitation or not.

> **Credits**: Aksiome

---

### Is It Raining?

**`bs.environment:is_raining`**

Determine if it is currently raining or not.

> **Credits**: Aksiome, theogiraudet

---

### Is It Thundering?

**`bs.environment:is_thundering`**

Determine if it is currently thundering or not.

> **Credits**: Aksiome, theogiraudet

---

```{include} ../_templates/comments.md
```
