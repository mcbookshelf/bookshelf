# 🧮 Math

**`#bs.math:help`**

The beatifull world of mathematics... **in Minecraft!**


```{image} /_imgs/modules/math-light.png
:align: center
:class: only-light
```

```{image} /_imgs/modules/math-dark.png
:align: center
:class: only-dark
```

```{epigraph}
"Mathematics has very subtle inventions that can be of great service, both to satisfy the curious and to facilitate all arts and reduce the labor of men."

-- René Descartes
```


```{button-link} https://youtu.be/Bt0HKaOosqU
:color: primary
:align: center
:shadow:

{octicon}`device-camera-video` Watch a demo
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Combine

```{function} #bs.math:combine

Compute the combine of 2 numbers.

:Inputs:
  **Scores `$math.combine.[n,k] bs.in`**: Numbers to be combined, the smaller input will be taken from the greater input.

:Outputs:
  **Return | Score `$math.combine bs.out`**: Result of the operation.
```

```{admonition} Technical Limitation
:class: important

The value of `bs.out` is incorrect if the result is greater than 2,147,483,647 or `$math.combine.[n,k] bs.in` are not both positive.
```

*Compute $combine(4,2)$:*
```mcfunction
# Once
scoreboard players set $math.combine.n bs.in 4
scoreboard players set $math.combine.k bs.in 2
function #bs.math:combine
tellraw @a [{"text": "combine(4,2) = ","color":"dark_gray"},{"score":{"name":"$math.combine","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Ethanout

---

### Exponential

::::{tab-set}
:::{tab-item} Natural

```{function} #bs.math:exp

Compute the exponential function.

:Inputs:
  **Storage `bs:in math.exp.x`**: {nbt}`number` Number to be exponentiated.

:Outputs:
  **Storage `bs:out math.exp`**: {nbt}`float` Result of the operation.
```

*Compute $exp(3)$:*
```mcfunction
# Once
data modify storage bs:in math.exp.x set value 3.0
function #bs.math:exp
data get storage bs:out math.exp
```

:::
:::{tab-item} Base 2

```{function} #bs.math:exp2

Compute the exponential function in base 2.

:Inputs:
  **Storage `bs:in math.exp2.x`**: {nbt}`number` Number to be exponentiated.

:Outputs:
  **Storage `bs:out math.exp2`**: {nbt}`float` Result of the operation.
```

*Compute $exp2(3)$:*
```mcfunction
# Once
data modify storage bs:in math.exp2.x set value 3.0
function #bs.math:exp2
data get storage bs:out math.exp2
```

::::

![](/_imgs/modules/math/exp.png)

> **Credits**: Aksiome

---

### Factorial

```{function} #bs.math:factorial

Compute the factorial of the number.

:Inputs:
  **Score `$math.factorial.n bs.in`**: Number to be factorialized.

:Outputs:
  **Return | Score `$math.factorial bs.out`**: Result of the operation.
```

```{admonition} Technical Limitation
:class: important

Due to the limit of integers that can be stored in a score, the interval of `$math.factorial.n bs.in` is limited to `[0,12]`.
```

*Compute $3!$:*
```mcfunction
# Once
scoreboard players set $math.factorial.n bs.in 3
function #bs.math:factorial
tellraw @a [{"text": "3! = ","color":"dark_gray"},{"score":{"name":"$math.factorial","objective":"bs.out"},"color":"gold"}]
```

![](/_imgs/modules/math/factorial.png)

> **Credits**: KubbyDev

---

### Float Manipulation

::::{tab-set}
:::{tab-item} Frexp

```{function} #bs.math:frexp

Decompose a floating point number into a normalized fraction and an integral power of two.

:Inputs:
  **Storage `bs:in math.frexp.x`**: {nbt}`number` Number to be decomposed.

:Outputs:
  **Storage `bs:out math.frexp.e`**: {nbt}`int` Exponent for the power of 2.

  **Storage `bs:out math.frexp.x`**: {nbt}`float` Normalized fraction in range  `]-1,-0.5]` or `[0.5,1[`.
```

*Decompose 5.8 into its mantissa and exponent:*
```mcfunction
# Once
data modify storage bs:in math.frexp.x set value 5.8
function #bs.math:frexp
data get storage bs:out math.frexp
```

:::
:::{tab-item} Ldexp

```{function} #bs.math:ldexp

Build a floating point number from a normalized fraction and an integral power of two.

:Inputs:
  **Storage `bs:in math.ldexp.x`**: {nbt}`number` Normalized fraction in range  `]-1,-0.5]` or `[0.5,1[`.

  **Storage `bs:in math.ldexp.e`**: {nbt}`int` Exponent for the power of 2.

:Outputs:
  **Storage `bs:out math.ldexp`**: {nbt}`float` Resulting floating-point number.
```

*Compose a floating-point number:*
```mcfunction
# Once
data modify storage bs:in math.ldexp.e set value 3
data modify storage bs:in math.ldexp.x set value 0.75
function #bs.math:ldexp
data get storage bs:out math.ldexp
```

:::
::::

> **Credits**: Aksiome

---

### Greatest Common Denominator

```{function} #bs.math:gcd

Compute the greatest common denominator of two numbers.

:Inputs:
  **Scores `$math.gcd.[a,b] bs.in`**: The two numbers.

:Outputs:
  **Return | Score `$math.gcd bs.out`**: The greatest common denominator.
```

*Calculate the greatest common denominator between 16 and 12:*
```mcfunction
# Once
scoreboard players set $math.gcd.a bs.in 16
scoreboard players set $math.gcd.b bs.in 12
function #bs.math:gcd
tellraw @a [{"text": "gcd(16,12) = ", "color": "dark_gray"},{"score":{"name":"$math.gcd", "objective": "bs.out"}, "color": "gold"}]
```

![](/_imgs/modules/math/gcd.png)

> **Credits**: Aksiome, Leirof

---

### Logarithm

::::{tab-set}

:::{tab-item} Natural

```{function} #bs.math:log

Compute the natural logarithm (base e) of a number.

:Inputs:
  **Storage `bs:in math.log.x`**: {nbt}`number` Number to be logarithmized.

:Outputs:
  **Storage `bs:out math.log`**: {nbt}`float` Result of the operation.
```

*Calculate $ln(28)$:*
```mcfunction
# Once
data modify storage bs:in math.log.x set value 28.0
function #bs.math:log
data get storage bs:out math.log
```

:::
:::{tab-item} Base 2

```{function} #bs.math:log2

Compute the logarithm in base 2 of a number.

:Inputs:
  **Storage `bs:in math.log2.x`**: {nbt}`number` Number to be logarithmized.

:Outputs:
  **Storage `bs:out math.log2`**: {nbt}`float` Result of the operation.
```

*Calculate $log_2(28)$:*
```mcfunction
# Once
data modify storage bs:in math.log2.x set value 28.0
function #bs.math:log2
data get storage bs:out math.log2
```
:::
:::{tab-item} Base 10

```{function} #bs.math:log10

Compute the logarithm in base 10 of a number.

:Inputs:
  **Storage `bs:in math.log10.x`**: {nbt}`number` Number to be logarithmized.

:Outputs:
  **Storage `bs:out math.log10`**: {nbt}`float` Result of the operation.
```

*Calculate $log_{10}(28)$:*
```mcfunction
# Once
data modify storage bs:in math.log10.x set value 28.0
function #bs.math:log10
data get storage bs:out math.log10
```

:::
:::{tab-item} Base a

```{function} #bs.math:loga

Compute the logarithm in base a of a number.

:Inputs:
  **Storage `bs:in math.loga.x`**: {nbt}`number` Number to be logarithmized.

  **Storage `bs:in math.loga.a`**: {nbt}`number` Base of the logarithm.

:Outputs:
  **Storage `bs:out math.loga`**: {nbt}`float` Result of the operation.
```

*Calculate $log_4(28)$:*
```mcfunction
# Once
data modify storage bs:in math.loga.a set value 4
data modify storage bs:in math.loga.x set value 28.0
function #bs.math:loga
data get storage bs:out math.loga
```

:::
::::

> **Credits**: Aksiome

---

### Power

::::{tab-set}

:::{tab-item} Integer

```{function} #bs.math:ipow

Compute the power of integer numbers.

:Inputs:
  **Score `$math.ipow.x bs.in`**: The base.

  **Score `$math.ipow.y bs.in`**: The exponent.
:Outputs:
  **Return | Score `$math.ipow bs.out`**: Result of the operation.
```

*Compute and display $3^6$:*
```mcfunction
# Once
scoreboard players set $math.ipow.x bs.in 3
scoreboard players set $math.ipow.y bs.in 6
function #bs.math:ipow
tellraw @a [{"text": "3^6 = ", "color": "dark_gray"},{"score":{"name":"$math.ipow", "objective": "bs.out"}, "color": "gold"}]
```

:::
:::{tab-item} Decimal

```{function} #bs.math:pow

Compute the power of floating numbers.

:Inputs:
  **Storage `bs:in math.pow.x`**: {nbt}`number` The base.

  **Storage `bs:in math.pow.y`**: {nbt}`number` The exponent.

:Outputs:
  **Storage `bs:out math.pow`**: {nbt}`float` Result of the operation.
```

*Compute and display $pow(3.5, 2.25)$:*
```mcfunction
# Once
data modify storage bs:in math.pow set value {x:3.5,y:2.25}
function #bs.math:pow
tellraw @a [{"text": "3.5^2.25 = ", "color": "dark_gray"},{"nbt": "math.pow", "storage": "bs:out", "color": "gold"}]
```

:::
::::

![](/_imgs/modules/math/power.png)

> **Credits**: Aksiome, Leirof

---

### Rounded Division

```{function} #bs.math:divide

Divide a number by another then round the result to the nearest integer (Minecraft rounds down to the next integer).

:Inputs:
  **Score `$math.divide.x bs.in`**: The numerator.

  **Score `$math.divide.y bs.in`**: The denominator.
:Outputs:
  **Return | Score `$math.divide bs.out`**: Result of the division.
```

*Calculate $9/5$:*
```mcfunction
# Once
scoreboard players set $math.divide.x bs.in 9
scoreboard players set $math.divide.y bs.in 5
function #bs.math:divide
tellraw @a [{"text": "9 / 5 = ", "color": "dark_gray"},{"score":{"name":"$math.divide", "objective": "bs.out"}, "color": "gold"}]
```

![](/_imgs/modules/math/divide.png)

> **Credits**: Aksiome, theogiraudet

---

### Square Root

::::{tab-set}

:::{tab-item} Integer

```{function} #bs.math:isqrt

Compute the square root of an integer number.

:Inputs:
  **Score `$math.isqrt.x bs.in`**: Number you want to calculate the square root of.

:Outputs:
  **Return | Score `$math.isqrt bs.out`**: Floored result of the square root.
```

*Calculate and display $\sqrt{42}$:*
```mcfunction
# Once
scoreboard players set $math.isqrt.x bs.in 42
function #bs.math:isqrt
tellraw @a [{"text": "sqrt(42) = ", "color": "dark_gray"},{"score":{"name":"$math.isqrt", "objective": "bs.out"}, "color": "gold"}]
```

:::
:::{tab-item} Decimal

```{function} #bs.math:sqrt

Compute the square root of a floating number.

:Inputs:
  **Storage `bs:in math.sqrt.x`**: {nbt}`number` Number you want to calculate the square root of.

:Outputs:
  **Storage `bs:out math.sqrt`**: {nbt}`float` Result of the operation.
```

*Calculate and display $\sqrt{42}$:*
```mcfunction
# Once
data modify storage bs:in math.sqrt.x set value 42
function #bs.math:sqrt
tellraw @a [{"text": "sqrt(42) = ", "color": "dark_gray"},{"nbt": "math.sqrt", "storage": "bs:out", "color": "gold"}]
```
:::
::::

![](/_imgs/modules/math/sqrt.png)

> **Credits**: Ethanout

---

### Trigonometry

::::{tab-set}
:::{tab-item} Acos

```{function} #bs.math:acos

Compute the arc cosine of a value between -1 and 1.

:Inputs:
  **Score `$math.acos.x bs.in`**: Value you want to compute the arccosine of, shifted by 3 digits (1,2345 → 1234) for better precision in integer scores.

:Outputs:
  **Return | Score `$math.acos bs.out`**: Result of the operation in degrees, shifted by 2 digits.
```

*Compute and display the arccosine of 0.42:*
```mcfunction
# Once
scoreboard players set $math.acos.x bs.in 420
function #bs.math:acos
tellraw @a [{"text":"acos(0.42) = ","color":"dark_gray"},{"score":{"name":"$math.acos","objective":"bs.out"},"color":"gold"}]
```

![](/_imgs/modules/math/arccos.png)

:::
:::{tab-item} Asin

```{function} #bs.math:asin

Compute the arc sine of a value between -1 and 1.

:Inputs:
  **Score `$math.asin.x bs.in`**: Value you want to compute the arcsine of, shifted by 3 digits (1,2345 → 1234) for better precision in integer scores.

:Outputs:
  **Return | Score `$math.asin bs.out`**: Result of the operation in degrees, shifted by 2 digits.
```

*Compute and display the arcsine of 0.42:*
```mcfunction
# Once
scoreboard players set $math.asin.x bs.in 420
function #bs.math:asin
tellraw @a [{"text":"asin(0.42) = ","color":"dark_gray"},{"score":{"name":"$math.asin","objective":"bs.out"},"color":"gold"}]
```

![](/_imgs/modules/math/arcsin.png)

:::
:::{tab-item} Atan

```{function} #bs.math:atan

Compute the arc tangent of a value between -infinite and +infinite.

:Inputs:
  **Score `$math.atan.x bs.in`**: Value you want to compute the arctangent of, shifted by 3 digits (1,2345 → 1234) for better precision in integer scores.

:Outputs:
  **Return | Score `$math.atan bs.out`**: Result of the operation in degrees, shifted by 2 digits.
```

*Compute and display the arctan of 0.42:*
```mcfunction
# Once
scoreboard players set $math.atan.x bs.in 420
function #bs.math:atan
tellraw @a [{"text":"atan(0.42) = ","color":"dark_gray"},{"score":{"name":"$math.atan","objective":"bs.out"},"color":"gold"}]
```

![](/_imgs/modules/math/arctan.png)

:::
:::{tab-item} Atan2

```{function} #bs.math:atan2

Compute the 2-argument arctangent of y and x.

:Inputs:
  **Scores `$math.atan2.[y,x] bs.in`**: Values you want to compute the arctangent of, shifted by 3 digits (1,2345 → 1234) for better precision in integer scores.

:Outputs:
  **Return | Score `$math.atan2 bs.out`**: Result of the operation in degrees, shifted by 2 digits.
```

*Compute and display the atan2 of (0.42, 0.8):*
```mcfunction
# Once
scoreboard players set $math.atan2.y bs.in 420
scoreboard players set $math.atan2.x bs.in 800
function #bs.math:atan2
tellraw @a [{"text":"atan2(0.42, 0.8) = ","color":"dark_gray"},{"score":{"name":"$math.atan2","objective":"bs.out"},"color":"gold"}]
```

:::
:::{tab-item} Cos

```{function} #bs.math:cos

Compute the cosine of an angle between 0 and 360.

:Inputs:
  **Score `$math.cos.x bs.in`**: Angle in degrees shifted by 2 digits (ex: 90.15 → 9015).

:Outputs:
  **Return | Score `$math.cos bs.out`**: Cosine of the angle shifted by 3 digits (ex: 0.42 → 420).
```

*Compute and display the cosine of 42:*
```mcfunction
# Once
scoreboard players set $math.cos.x bs.in 4200
function #bs.math:cos
tellraw @a [{"text": "cos(42) = ", "color": "dark_gray"},{"score":{"name":"$math.cos", "objective": "bs.out"}, "color": "gold"}]
```

![](/_imgs/modules/math/cosine.png)

```{admonition} How does it work?
:class: dropdown

This functions use the Bhaskara approximation which tell us that

$$
\sin(x) \approx \frac{4x(180-x)}{40500-x(180-x)} \quad \forall x \in [0, 180]
$$

From this relation, and using the properties
- $\sin(-x) = -\sin(x)$ (antisymetry)
- $\sin(x+360) = \sin(x)$ (periodicity)

We can compute the sine of any angle and thus the cosine.

![](/_imgs/modules/math/bhaskara.png)

```

:::
:::{tab-item} Sin

```{function} #bs.math:sin

Compute the sine of an angle between 0 and 360.

:Inputs:
  **Score `$math.sin.x bs.in`**: Angle in degrees shifted by 2 digits (ex: 90.15 → 9015).

:Outputs:
  **Return | Score `$math.sin bs.out`**: Sine of the angle shifted by 3 digits (ex: 0.42 → 420).
```

*Compute and display the sine of 42:*
```mcfunction
# Once
scoreboard players set $math.sin.x bs.in 4200
function #bs.math:sin
tellraw @a [{"text": "sin(42) = ", "color": "dark_gray"},{"score":{"name":"$math.sin", "objective": "bs.out"}, "color": "gold"}]
```

![](/_imgs/modules/math/sine.png)

```{admonition} How does it work?
:class: dropdown

This functions use the Bhaskara approximation which tell us that

$$
\sin(x) \approx \frac{4x(180-x)}{40500-x(180-x)} \quad \forall x \in [0, 180]
$$

From this relation, and using the properties
- $\sin(-x) = -\sin(x)$ (antisymetry)
- $\sin(x+360) = \sin(x)$ (periodicity)

We can compute the sine of any angle.

![](/_imgs/modules/math/bhaskara.png)

```

:::
:::{tab-item} Tan

```{function} #bs.math:tan

Compute the tangent of an angle between 0 and 360.

:Inputs:
  **Score `$math.tan.x bs.in`**: Angle in degrees shifted by 2 digits (ex: 90.15 → 9015).

:Outputs:
  **Return | Score `$math.tan bs.out`**: Tangent of the angle shifted by 3 digits (ex: 0.42 → 420).
```

*Compute and display the tangent of 42:*
```mcfunction
# Once
scoreboard players set $math.tan.x bs.in 4200
function #bs.math:tan
tellraw @a [{"text": "tan(42) = ", "color": "dark_gray"},{"score":{"name":"$math.tan", "objective": "bs.out"}, "color": "gold"}]
```

![](/_imgs/modules/math/tangent.png)

:::
:::{tab-item} Sincos

```{function} #bs.math:sincos

Compute both the sine and cosine of an angle between 0 and 360 in a single operation.

:Inputs:
  **Score `$math.sincos.x bs.in`**: Angle in degrees shifted by 2 digits (ex: 90.15 → 9015).

:Outputs:
  **Score `$math.sincos.cos bs.out`**: Cosine of the angle shifted by 3 digits (ex: 0.42 → 420).

  **Score `$math.sincos.sin bs.out`**: Sine of the angle shifted by 3 digits (ex: 0.42 → 420).
```

*Compute and display the sine and cosine of 42:*
```mcfunction
# Once
scoreboard players set $math.sincos.x bs.in 4200
function #bs.math:sincos
tellraw @a [{"text": "cos(42) = ", "color": "dark_gray"},{"score":{"name":"$math.sincos.cos", "objective": "bs.out"}, "color": "gold"}]
tellraw @a [{"text": "sin(42) = ", "color": "dark_gray"},{"score":{"name":"$math.sincos.sin", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} How does this method differ from cos and sin?
:class: dropdown

This function utilizes Minecraft teleportation to calculate both the cosine and sine values. While it's slightly less efficient than calling either cos or sin individually, it allows for computing both in a single operation.
```

:::
::::

> **Credits**: Aksiome, KubbyDev, Leirof

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
