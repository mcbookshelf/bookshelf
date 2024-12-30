# 🖥️ Bitwise

**`#bs.bitwise:help`**

A collection of various bitwise operations, providing versatile tools for manipulating binary data.

```{image} /_imgs/modules/bitwise-light.png
:align: center
:class: only-light p-2
```

```{image} /_imgs/modules/bitwise-dark.png
:align: center
:class: only-dark p-2
```

```{epigraph}
"Binary is a very simple numbering system, but it is incredibly powerful when used correctly."

-- Alan Turing
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Bit Count

```{function} #bs.bitwise:bit_count

Get the number of ones in the binary representation of a number.

:Inputs:
  **Score `$bitwise.bit_count.n bs.in`**: Number to get the bit_count of.

:Outputs:
  **Return | Score `$bitwise.bit_count bs.out`**: Number of positive bits needed to represent the number.
```

*Compute and display how much positive bits 12 has:*
```mcfunction
# Once
scoreboard players set $bitwise.bit_count.n bs.in 12
function #bs.bitwise:bit_count

# See the result
tellraw @a [{"text":"Number of bits for 12 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.bit_count","objective":"bs.out"}}]
```

> **Credits**: Aksiome

---

### Bit Length

```{function} #bs.bitwise:bit_length

Get the number of bits necessary to represent a number.

:Inputs:
  **Score `$bitwise.bit_length.n bs.in`**: Number to get the bit_length of.

:Outputs:
  **Return | Score `$bitwise.bit_length bs.out`**: Number of bits needed to represent the number.
```

*Compute and display how much bits 12 has:*
```mcfunction
# Once
scoreboard players set $bitwise.bit_length.n bs.in 12
function #bs.bitwise:bit_length

# See the result
tellraw @a [{"text":"Number of bits for 12 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.bit_length","objective":"bs.out"}}]
```

> **Credits**: Aksiome, theogiraudet

---

### Complement to 2

```{function} #bs.bitwise:two_complement

Compute the two's complement of a number.

:Inputs:
  **Score `$bitwise.two_complement.n bs.in`**: Number to compute the two's complement of.

:Outputs:
  **Return | Score `$bitwise.two_complement bs.out`**: The two's complement of the number.
```

*Compute and display the two's complement of -12:*
```mcfunction
# Once
scoreboard players set $bitwise.two_complement.n bs.in -12
function #bs.bitwise:two_complement

# See the result
tellraw @a [{"text":"Two's complement of -12 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.two_complement","objective":"bs.out"}}]
```

> **Credits**: Aksiome, theogiraudet

---

### Logical Operators

::::{tab-set}
:::{tab-item} And

```{function} #bs.bitwise:and

Compute the bitwise conjunction of two numbers.

:Inputs:
  **Score `$bitwise.and.a bs.in`**: First operand $=a$.

  **Score `$bitwise.and.b bs.in`**: Second operand $=b$.

:Outputs:
  **Return | Score `$bitwise.and bs.out`**: Result of the operation $=a \land b$.
```

*Compute and display $-9 \land 57$:*
```mcfunction
# Once
scoreboard players set $bitwise.and.a bs.in -9
scoreboard players set $bitwise.and.b bs.in 57
function #bs.bitwise:and

# See the result
tellraw @a [{"text":"-9 & 57 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.and","objective":"bs.out"}}]
```

:::
:::{tab-item} Or

```{function} #bs.bitwise:or

Compute the bitwise disjunction of two numbers.

:Inputs:
  **Score `$bitwise.or.a bs.in`**: First operand $=a$.

  **Score `$bitwise.or.b bs.in`**: Second operand $=b$.

:Outputs:
  **Return | Score `$bitwise.or bs.out`**: Result of the operation $=a \lor b$.
```

*Compute and display $-9 \lor 57$:*
```mcfunction
# Once
scoreboard players set $bitwise.or.a bs.in -9
scoreboard players set $bitwise.or.b bs.in 57
function #bs.bitwise:or

# See the result
tellraw @a [{"text":"-9 | 57 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.or","objective":"bs.out"}}]
```

:::
:::{tab-item} Xor

```{function} #bs.bitwise:xor

Compute the exclusive bitwise disjunction of two numbers.

:Inputs:
  **Score `$bitwise.xor.a bs.in`**: First operand $=a$.

  **Score `$bitwise.xor.b bs.in`**: Second operand $=b$.

:Outputs:
  **Return | Score `$bitwise.xor bs.out`**: Result of the operation $=a \oplus b$.
```

*Compute and display $-9 \oplus 57$:*
```mcfunction
# Once
scoreboard players set $bitwise.xor.a bs.in -9
scoreboard players set $bitwise.xor.b bs.in 57
function #bs.bitwise:xor

# See the result
tellraw @a [{"text":"-9 ^ 57 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.xor","objective":"bs.out"}}]
```

:::
:::{tab-item} Not

```{function} #bs.bitwise:not

Compute the bitwise negation of a number.

:Inputs:
  **Score `$bitwise.not.n bs.in`**: Number to negate.

:Outputs:
  **Return | Score `$bitwise.not bs.out`**: Result of the not operation.
```

*Compute and display $\lnot 452$:*
```mcfunction
# Once
scoreboard players set $bitwise.not.n bs.in 452
function #bs.bitwise:not

# See the result
tellraw @a [{"text":"~452 = ","color":"#e0c7ff"},{"score":{"name":"$bitwise.not","objective":"bs.out"}}]
```

:::
::::

> **Credits**: Aksiome, theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
