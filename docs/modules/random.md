# 🎲 Random

**`#bs.random:help`**

Generate random values, weighted picks, and noise patterns.

```{image} /_imgs/modules/random.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"Creativity is the ability to introduce order into the randomness of nature."

-- Eric Hoffer
```

---

## Functions

The following functions are available in this module.

---

### Random choice

:::::{tab-set}
::::{tab-item} Choice

```{feature} bs.random:choice
```

*Example: pick a random fruit*

```mcfunction
# Once
function #bs.random:choice.in {options:["Apple","Banana","Strawberry","Blueberry","Mango","Watermelon"]}

# See the result
data get storage bs.random:choice out
```

::::
::::{tab-item} Weighted choice

```{feature} bs.random:weighted_choice
```

*Example: pick a random fruit, apples being the most likely*

```mcfunction
# Once
function #bs.random:weighted_choice.in {options:["Apple","Banana","Strawberry"],weights:[5,3,2]}

# See the result
data get storage bs.random:weighted_choice out
```

````{admonition} Longer lists
:class: tip

This function takes at most 256 values. For more, write an integer provider of your own with a `weighted_list` that gives the index of a value, then read your list at that index. Its weights are written in the provider, so they cannot change from one call to the next.

```json
{
  "type": "weighted_list",
  "distribution": [
    {"data": 0, "weight": 5},
    {"data": 1, "weight": 3},
    {"data": 2, "weight": 2}
  ]
}
```
````

::::
:::::

---

### Noise

Noise gives values that change smoothly from one position to the next, for terrain, textures or any natural looking variation. The same seed and position always give the same value.

Each noise has a function for 1, 2 and 3 dimensions: a line, a surface such as the ground, or a volume such as caves. `pos` holds as many coordinates.

#### Simplex noise

:::::{tab-set}
::::{tab-item} 1D

```{feature} function bs.random:simplex_noise/1d
```

*Example: get the noise at your x position, with cells of 16 blocks*

```mcfunction
# Once
data modify storage bs.random:simplex_noise in set value {pos:[0],size:16,seed:42}
execute store result storage bs.random:simplex_noise in.pos[0] int 1 run data get entity @s Pos[0]
function #bs.random:simplex_noise/1d

# See the result
data get storage bs.random:simplex_noise out
```

::::
::::{tab-item} 2D

```{feature} function bs.random:simplex_noise/2d
```

*Example: get the noise at the block you stand on, with cells of 16 blocks*

```mcfunction
# Once
data modify storage bs.random:simplex_noise in set value {pos:[0,0],size:16,seed:42}
execute store result storage bs.random:simplex_noise in.pos[0] int 1 run data get entity @s Pos[0]
execute store result storage bs.random:simplex_noise in.pos[1] int 1 run data get entity @s Pos[2]
function #bs.random:simplex_noise/2d

# See the result
data get storage bs.random:simplex_noise out
```

::::
::::{tab-item} 3D

```{feature} function bs.random:simplex_noise/3d
```

*Example: get the noise at your position, height included, with cells of 16 blocks*

```mcfunction
# Once
data modify storage bs.random:simplex_noise in set value {pos:[0,0,0],size:16,seed:42}
execute store result storage bs.random:simplex_noise in.pos[0] int 1 run data get entity @s Pos[0]
execute store result storage bs.random:simplex_noise in.pos[1] int 1 run data get entity @s Pos[1]
execute store result storage bs.random:simplex_noise in.pos[2] int 1 run data get entity @s Pos[2]
function #bs.random:simplex_noise/3d

# See the result
data get storage bs.random:simplex_noise out
```

::::
:::::

#### Fractal noise

:::::{tab-set}
::::{tab-item} 1D

```{feature} function bs.random:fractal_noise/1d
```

*Example: get a detailed noise at your x position, with 4 layers*

```mcfunction
# Once
data modify storage bs.random:fractal_noise in set value {pos:[0],size:64,seed:42,octaves:4,persistence:0.5,lacunarity:2.0}
execute store result storage bs.random:fractal_noise in.pos[0] int 1 run data get entity @s Pos[0]
function #bs.random:fractal_noise/1d

# See the result
data get storage bs.random:fractal_noise out
```

::::
::::{tab-item} 2D

```{feature} function bs.random:fractal_noise/2d
```

*Example: get a detailed noise at the block you stand on, with 4 layers*

```mcfunction
# Once
data modify storage bs.random:fractal_noise in set value {pos:[0,0],size:64,seed:42,octaves:4,persistence:0.5,lacunarity:2.0}
execute store result storage bs.random:fractal_noise in.pos[0] int 1 run data get entity @s Pos[0]
execute store result storage bs.random:fractal_noise in.pos[1] int 1 run data get entity @s Pos[2]
function #bs.random:fractal_noise/2d

# See the result
data get storage bs.random:fractal_noise out
```

::::
::::{tab-item} 3D

```{feature} function bs.random:fractal_noise/3d
```

*Example: get a detailed noise at your position, height included, with 4 layers*

```mcfunction
# Once
data modify storage bs.random:fractal_noise in set value {pos:[0,0,0],size:64,seed:42,octaves:4,persistence:0.5,lacunarity:2.0}
execute store result storage bs.random:fractal_noise in.pos[0] int 1 run data get entity @s Pos[0]
execute store result storage bs.random:fractal_noise in.pos[1] int 1 run data get entity @s Pos[1]
execute store result storage bs.random:fractal_noise in.pos[2] int 1 run data get entity @s Pos[2]
function #bs.random:fractal_noise/3d

# See the result
data get storage bs.random:fractal_noise out
```

::::
:::::

::::{grid} 1 2 2 2
:::{grid-item-card} Simplex noise
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/random/simplex_noise.png)
:::

:::{grid-item-card} Fractal noise
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/random/fractal_noise.png)
:::
::::

```{admonition} Fill a grid of noise
:class: tip

Call the function once per cell, from a loop of your own. Each call is cheap, so a whole area can be filled in a single tick.
```

---

## Number providers

The following number providers are available in this module. `normal` is a float provider, `uniform` is both an integer and a float provider, and the others are integer providers. Each one gives a new random value every time it is computed.

---

### Distributions

:::::{tab-set}
::::{tab-item} Uniform

```{feature} context_int_provider bs.random:uniform
```

*Example: roll a number from 1 to 100*

```mcfunction
# Once
data modify storage bs.random:uniform in set value {min:1,max:100}
data modify storage bs.random:uniform out set compute default integer bs.random:uniform

# See the result
data get storage bs.random:uniform out
```

```{feature} context_float_provider bs.random:uniform
```

*Example: get a fraction from 0 to 1*

```mcfunction
# Once
data modify storage bs.random:uniform in set value {min:0.0,max:1.0}
data modify storage bs.random:uniform out set compute default float bs.random:uniform

# See the result
data get storage bs.random:uniform out
```

```{dropdown} What is a uniform distribution?
:color: info
:icon: question

Every outcome has the same probability, like a fair die where each face is as likely as the others.
```

::::
::::{tab-item} Binomial

```{feature} bs.random:binomial
```

*Example: count the successes out of 10 trials of 20%*

```mcfunction
# Once
data modify storage bs.random:binomial in set value {trials:10,probability:0.2}
data modify storage bs.random:binomial out set compute default integer bs.random:binomial

# See the result
data get storage bs.random:binomial out
```

```{dropdown} What is a binomial distribution?
:color: info
:icon: question

It counts the successes out of a fixed number of trials, each with two outcomes, such as the heads out of 10 coin flips.
```

::::
::::{tab-item} Geometric

```{feature} bs.random:geometric
```

*Example: count the trials until the first success, with 2% of success each*

```mcfunction
# Once
data modify storage bs.random:geometric in set value {probability:0.02}
data modify storage bs.random:geometric out set compute default integer bs.random:geometric

# See the result
data get storage bs.random:geometric out
```

```{dropdown} What is a geometric distribution?
:color: info
:icon: question

It counts the trials needed to get the first success, such as the number of rolls needed to get a six.
```

::::
::::{tab-item} Normal

```{feature} bs.random:normal
```

*Example: get a number around 10, with a spread of 3*

```mcfunction
# Once
data modify storage bs.random:normal in set value {mean:10.0,spread:3.0}
data modify storage bs.random:normal out set compute default float bs.random:normal

# See the result
data get storage bs.random:normal out
```

```{dropdown} What is a normal distribution?
:color: info
:icon: question

Also known as the Gaussian distribution, it gives values clustered around the mean in a bell-shaped curve, as natural variations and measurement errors often are. About 68% of the values fall within one spread of the mean. Bookshelf adds 12 random numbers to get this curve: values far from the mean are a little rarer than in theory, and none is more than 6 spreads away.
```

::::
::::{tab-item} Poisson

```{feature} bs.random:poisson
```

*Example: count the events in an interval where 5 happen on average*

```mcfunction
# Once
data modify storage bs.random:poisson in set value {lambda:5.0}
data modify storage bs.random:poisson out set compute default integer bs.random:poisson

# See the result
data get storage bs.random:poisson out
```

```{dropdown} What is a Poisson distribution?
:color: info
:icon: question

It counts how many events happen in an interval when they happen at a steady rate, given the average count, **λ (lambda)**. Results cluster around lambda.
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

---

```{include} ../_templates/comments.md
```
