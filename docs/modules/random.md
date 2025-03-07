# 🎲 Random

**`#bs.random:help`**

Contains many random functions for different distributions and noise patterns.

```{image} /_imgs/modules/random.png
:align: center
:class: dark_light p-2
```

```{epigraph}
"Creativity is the ability to introduce order into the randomness of nature."

-- Eric Hoffer
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Random Choice

:::::{tab-set}
::::{tab-item} Choice

```{function} #bs.random:choice

Select a random value from a list.

:Inputs:
  **Storage `bs:in random.choice.options`**: {nbt}`list` The list of values to choose from.

:Outputs:
  **Storage `bs:out random.choice`**: {nbt}`any` The randomly selected value.

  **Return**: The index of the chosen value.
```

*Pick a random fruit from the list:*

```mcfunction
# Populate list with values
data modify storage bs:in random.choice.options set value ["Apple", "Banana", "Strawberry", "Blueberry", "Mango", "Watermelon"]

# Randomly select one
function #bs.random:choice

# Display the result
tellraw @a [{"text":"Value: ","color":"dark_gray"},{"nbt":"random.choice","storage":"bs:out","color":"gold"}]
```

::::
::::{tab-item} Weighted Choice

```{function} #bs.random:weighted_choice

Select a random value from a list based on specified weights.

:Inputs:
  **Storage `bs:in random.weighted_choice.options`**: {nbt}`list` The list of values to choose from.

  **Storage `bs:in random.weighted_choice.weights`**: {nbt}`list` The corresponding weights for each value.

:Outputs:
  **Storage `bs:out random.weighted_choice`**: {nbt}`any` The randomly selected value based on the weights.

  **Return**: The index of the chosen value.
```

*Pick a random fruit from the list based on weights:*

```mcfunction
# Populate list with values
data modify storage bs:in random.weighted_choice.options set value ["Apple", "Banana", "Strawberry"]

# Populate list with weights
data modify storage bs:in random.weighted_choice.weights set value [5, 3, 2]

# Randomly select one based on weights
function #bs.random:weighted_choice

# Display the result
tellraw @a [{"text":"Value: ","color":"dark_gray"},{"nbt":"random.weighted_choice","storage":"bs:out","color":"gold"}]
```

:::::

> **Credits**: Aksiome, SBtree

---

### Random Distributions

:::::{tab-set}
::::{tab-item} Uniform

```{function} #bs.random:uniform {min:<min>,max:<max>}

Generate a random number uniformly distributed between `min` and `max`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **min**: The lower bound.
    - {nbt}`int` **max**: The upper bound.
  :::

:Outputs:
  **Return | Score `$random.uniform bs.out`**: A random integer in range [`min`, `max`].
```

*Generate a random number between 1 and 100:*

```mcfunction
# Generate random number
function #bs.random:uniform {min:1,max:100}

# Display the result
tellraw @a [{"text": "Number: ", "color": "dark_gray"},{"score":{"name":"$random.uniform", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Uniform Distribution... 🥶 What’s this?
:class: dropdown

Every outcome has an equal chance of happening. It's like rolling a fair die. Each number (1 through 6) is equally likely.
```

::::
::::{tab-item} Binomial

```{function} #bs.random:binomial {trials:<trials>,probability:<probability>}

Generate a random number with a binomial distribution using the specified `trials` and `probability`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **trials**: The number of Bernoulli trials. Maximum accepted value is 1000.
    - {nbt}`double` **probability**: The probability of success of each Bernoulli trial, in range [0,1].
  :::

:Outputs:
  **Return | Score `$random.binomial bs.out`**: A random integer in range [0, `trials`].
```

*Generate a random number with 10 trials and a 20% success chance:*

```mcfunction
# Generate random number
function #bs.random:binomial {trials:10,probability:0.2}

# Display the result
tellraw @a [{"text": "Number: ", "color": "dark_gray"},{"score":{"name":"$random.binomial", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Binomial Distribution... 🥶 What’s this?
:class: dropdown

Used when you have a fixed number of trials, each with two possible outcomes (like success or failure). It tells you the probability of getting a certain number of successes. For example, flipping a coin 10 times and counting how many heads you get.
```

::::
::::{tab-item} Geometric

```{function} #bs.random:geometric {probability:<probability>}

Generate a random number following a geometric distribution with the given `probability`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`double` **probability**: The probability of stopping at each trial, in range [0,1].
  :::

:Outputs:
  **Return | Score `$random.geometric bs.out`**: A random integer in range [0, 1000].
```

*Generate a random number with a 2% chance of stopping:*

```mcfunction
# Generate random number
function #bs.random:geometric {probability:0.02}

# Display the result
tellraw @a [{"text": "Number: ", "color": "dark_gray"},{"score":{"name":"$random.geometric", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Geometric Distribution... 🥶 What’s this?
:class: dropdown

Measures the number of trials needed to get the first success in a series of independent and identical trials. For instance, how many times you need to roll a die before getting a six.
```

::::
::::{tab-item} Poisson

```{function} #bs.random:poisson {lambda:<lambda>}

Generate a random number following a Poisson distribution with the expected value `lambda`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`double` **lambda**: The expected value in range [0,10].
  :::

:Outputs:
  **Return | Score `$random.poisson bs.out`**: A random integer, biased towards the `lambda` value.
```

*Generate a random number biased towards 5:*

```mcfunction
# Generate random number
function #bs.random:poisson {lambda:5}

# Display the result
tellraw @a [{"text": "Number: ", "color": "dark_gray"},{"score":{"name":"$random.poisson", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Poisson Distribution... 🥶 What’s this?
:class: dropdown

A Poisson distribution produces values that tend to cluster around an average value, **λ (lambda)**. Most results will be close to this average, which makes it useful for modeling random events happening at a consistent rate.
```

::::
:::::

```{image} /_imgs/modules/random/distributions_dark.png
:align: center
:class: only-dark
```

```{image} /_imgs/modules/random/distributions_light.png
:align: center
:class: only-light
```

> **Credits**: Aksiome, SBtree

---

### Noise Algorithms

:::::{tab-set}
::::{tab-item} Simplex Noise

```{function} #bs.random:simplex_noise_2d

Compute the simplex noise value at given coordinates. Simplex noise is a type of gradient noise, similar to Perlin noise, used for textures or procedural generation.

:Inputs:
  **Score `$random.simplex_noise_2d.seed bs.in`**: The seed used for generation.

  **Scores `$random.simplex_noise_2d.[x,y] bs.in`**: Coordinates, scaled by 1000 (e.g., for a cell size of 16, multiply by 1000/16).

:Outputs:
  **Return | Score `$random.simplex_noise_2d bs.out`**: The noise value in range [-1000,1000]
```

*Generate a random noise value:*

```mcfunction
# Generate random noise value
scoreboard players set $random.simplex_noise_2d.x bs.in 15589
scoreboard players set $random.simplex_noise_2d.y bs.in 812
execute store result score $random.simplex_noise_2d.seed bs.in run random value -1000000000..1000000000
function #bs.random:simplex_noise_2d
```

::::
::::{tab-item} Fractal Noise

```{function} #bs.random:fractal_noise_2d

Generate fractal noise by combining multiple noise layers at different scales, often used for terrain generation.

:Inputs:
  **Score `$random.fractal_noise_2d.seed bs.in`**: The seed used for generation.

  **Scores `$random.fractal_noise_2d.[x,y] bs.in`**: Coordinates, scaled by 1000 (e.g., for a cell size of 16, multiply by 1000/16).

  **Score `$random.fractal_noise_2d.octaves bs.in`**: Number of noise layers to combine (more octaves = more detail).

  **Score `$random.fractal_noise_2d.persistence bs.in`**: Contribution of each octave to the total noise, scaled by 1000.

  **Score `$random.fractal_noise_2d.lacunarity bs.in`**: Increase in frequency for each octave, scaled by 1000.

:Outputs:
  **Return | Score `$random.fractal_noise_2d bs.out`**: The noise value in range [-1000,1000]
```

*Generate a random noise value:*

```mcfunction
# Generate random noise value
scoreboard players set $random.fractal_noise_2d.x bs.in 15589
scoreboard players set $random.fractal_noise_2d.y bs.in 812
scoreboard players set $random.fractal_noise_2d.octaves bs.in 4
scoreboard players set $random.fractal_noise_2d.persistence bs.in 500
scoreboard players set $random.fractal_noise_2d.lacunarity bs.in 2000
execute store result score $random.fractal_noise_2d.seed bs.in run random value -1000000000..1000000000
function #bs.random:fractal_noise_2d
```

::::
:::::

> **Credits**: Aksiome, SBtree

---

### Noise Matrices

:::::{tab-set}
::::{tab-item} White Noise 1D

```{function} #bs.random:white_noise_mat_1d {length:<length>,with:{}}

Generate a 1-dimensional array of white noise values.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **length**: Length of the array to generate.
    - {nbt}`compound` **with**:
      - {nbt}`number` **scale**: Scalar for the function's output (default: 1).
  :::

:Outputs:
  **Storage `bs:out random.white_noise_mat_1d`**: {nbt}`list` Array of values between 0 and {scale}.
```

*Generate 4 random values:*

```mcfunction
# Generate random noise
function #bs.random:white_noise_mat_1d {length:4,with:{}}

# Display the result
tellraw @a [{"text": "Noise: ", "color": "dark_gray"},{"nbt":"white_noise_mat_1d","storage":"bs:out", "color": "gold"}]
```

::::
::::{tab-item} White Noise 2D

```{function} #bs.random:white_noise_mat_2d {width:<width>,height:<height>,with:{}}

Generate a 2-dimensional array of white noise values.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **width**: Width of the array to generate.
    - {nbt}`int` **height**: Height of the array to generate.
    - {nbt}`compound` **with**:
      - {nbt}`number` **scale**: Scalar for the function's output (default: 1).
  :::

:Outputs:
  **Storage `bs:out random.white_noise_mat_2d`**: {nbt}`list` 2D array of values between 0 and {scale}.
```

*Generate a 4x4 random noise pattern:*

```mcfunction
# Generate random noise
function #bs.random:white_noise_mat_2d {width:4,height:4,with:{}}

# Display the result
tellraw @a [{"text": "Noise: ", "color": "dark_gray"},{"nbt":"white_noise_mat_2d","storage":"bs:out", "color": "gold"}]
```
::::
::::{tab-item} Simplex Noise 2D

```{function} #bs.random:simplex_noise_mat_2d {width:<width>,height:<height>,with:{}}

Generate a 2D simplex noise texture of size `width` by `height`. Simplex noise is a gradient noise often used for textures.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **width**: Width of the array to generate.
    - {nbt}`int` **height**: Height of the array to generate.
    - {nbt}`compound` **with**:
      - {nbt}`int` **size**: Size of the noise "cell" (default: 16). Lower size means more detail.
      - {nbt}`int` **seed**: Seed for the noise generation, allowing for reproducibility (default: random).
      - {nbt}`number` **scale**: Scalar for the function's output (default: 1).
  :::

:Outputs:
  **Storage `bs:out random.simplex_noise_mat_2d`**: 2D array of values between {-scale} and {scale}.
```

*Generate a 16×16 simplex noise pattern:*

```mcfunction
# Generate random noise
function #bs.random:simplex_noise_mat_2d {width:16,height:16,with:{size:8}}

# Display the result
tellraw @a [{"text": "Noise: ", "color": "dark_gray"},{"nbt":"simplex_noise_mat_2d","storage":"bs:out", "color": "gold"}]
```

::::
::::{tab-item} Fractal Noise 2D

```{function} #bs.random:fractal_noise_mat_2d {width:<width>,height:<height>,with:{}}

Generate a 2D fractal noise texture of size `width` by `height`. Fractal noise combines multiple layers of noise for detailed textures.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **width**: Width of the array to generate.
    - {nbt}`int` **height**: Height of the array to generate.
    - {nbt}`compound` **with**:
      - {nbt}`int` **size**: Size of the noise "cell" (default: 16). Lower size means more detail.
      - {nbt}`int` **seed**: Seed for the noise generation, allowing for reproducibility (default: random).
      - {nbt}`int` **octaves**: Number of noise layers (default: 4). More octaves = more detail.
      - {nbt}`double` **persistence**: Contribution of each octave (default: 0.5). Higher means more detail.
      - {nbt}`double` **lacunarity**: Increase in frequency for each octave (default: 2.0). Higher means more rapid frequency increase.
      - {nbt}`number` **scale**: Scalar for the function's output (default: 1).
  :::

:Outputs:
  **Storage `bs:out random.fractal_noise_mat_2d`**: 2D array of values between {-scale} and {scale}.
```

*Generate a 16×16 fractal noise pattern:*

```mcfunction
# Generate random noise
function #bs.random:fractal_noise_mat_2d {width:16,height:16,with:{size:8}}

# Display the result
tellraw @a [{"text": "Noise: ", "color": "dark_gray"},{"nbt":"fractal_noise_mat_2d","storage":"bs:out", "color": "gold"}]
```

::::
:::::

::::{grid} 3
:::{grid-item-card} White Noise
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/random/white_noise.png)

:::

:::{grid-item-card} Simplex Noise
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/random/simplex_noise.png)
:::

:::{grid-item-card} Fractal Noise
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/random/fractal_noise.png)
:::
::::

> **Credits**: Aksiome, SBtree

---

```{include} ../_templates/comments.md
```
