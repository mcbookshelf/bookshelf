# 🖥️ Bitwise

**`#bs.bitwise:help`**

Manipulate integers as sequences of bits.

```{image} /_imgs/modules/bitwise-light.png
:align: center
:class: only-light p-2
```

```{image} /_imgs/modules/bitwise-dark.png
:align: center
:class: only-dark p-2
```

```{pull-quote}
"Binary is a very simple numbering system, but it is incredibly powerful when used correctly."

-- Alan Turing
```

---

## Number providers

The following number providers are available in this module. Each one reads its operands from a storage and computes an integer, which any command taking a number provider can use.

---

```{feature} bs.bitwise:and
```

*Example: compute $-9 \land 57$*

```mcfunction
# Once
data modify storage bs.bitwise:and in set value {a:-9,b:57}
data modify storage bs.bitwise:and out set compute default integer bs.bitwise:and

# See the result
tellraw @a [{"text":"-9 & 57 = "},{"nbt":"out","storage":"bs.bitwise:and"}]
```

---

```{feature} bs.bitwise:bit_count
```

*Example: count the bits set in 12*

```mcfunction
# Once
data modify storage bs.bitwise:bit_count in set value {n:12}
data modify storage bs.bitwise:bit_count out set compute default integer bs.bitwise:bit_count

# See the result
tellraw @a [{"text":"12 has "},{"nbt":"out","storage":"bs.bitwise:bit_count"},{"text":" bits set"}]
```

---

```{feature} bs.bitwise:bit_length
```

*Example: count the bits needed to represent 12*

```mcfunction
# Once
data modify storage bs.bitwise:bit_length in set value {n:12}
data modify storage bs.bitwise:bit_length out set compute default integer bs.bitwise:bit_length

# See the result
tellraw @a [{"text":"12 fits in "},{"nbt":"out","storage":"bs.bitwise:bit_length"},{"text":" bits"}]
```

---

```{feature} bs.bitwise:not
```

*Example: compute $\lnot 452$*

```mcfunction
# Once
data modify storage bs.bitwise:not in set value {n:452}
data modify storage bs.bitwise:not out set compute default integer bs.bitwise:not

# See the result
tellraw @a [{"text":"~452 = "},{"nbt":"out","storage":"bs.bitwise:not"}]
```

---

```{feature} bs.bitwise:or
```

*Example: compute $-9 \lor 57$*

```mcfunction
# Once
data modify storage bs.bitwise:or in set value {a:-9,b:57}
data modify storage bs.bitwise:or out set compute default integer bs.bitwise:or

# See the result
tellraw @a [{"text":"-9 | 57 = "},{"nbt":"out","storage":"bs.bitwise:or"}]
```

---

```{feature} bs.bitwise:shift_left
```

*Example: compute $5 \ll 3$*

```mcfunction
# Once
data modify storage bs.bitwise:shift_left in set value {n:5,by:3}
data modify storage bs.bitwise:shift_left out set compute default integer bs.bitwise:shift_left

# See the result
tellraw @a [{"text":"5 << 3 = "},{"nbt":"out","storage":"bs.bitwise:shift_left"}]
```

---

````{feature} bs.bitwise:shift_right
```{admonition} Negative numbers
:class: tip

The sign is kept: shifting `-8` right by `1` gives `-4`, as `>>` does in most languages.
```
````

*Example: compute $-8 \gg 1$*

```mcfunction
# Once
data modify storage bs.bitwise:shift_right in set value {n:-8,by:1}
data modify storage bs.bitwise:shift_right out set compute default integer bs.bitwise:shift_right

# See the result
tellraw @a [{"text":"-8 >> 1 = "},{"nbt":"out","storage":"bs.bitwise:shift_right"}]
```

---

```{feature} bs.bitwise:xor
```

*Example: compute $-9 \oplus 57$*

```mcfunction
# Once
data modify storage bs.bitwise:xor in set value {a:-9,b:57}
data modify storage bs.bitwise:xor out set compute default integer bs.bitwise:xor

# See the result
tellraw @a [{"text":"-9 ^ 57 = "},{"nbt":"out","storage":"bs.bitwise:xor"}]
```

---

```{include} ../_templates/comments.md
```
