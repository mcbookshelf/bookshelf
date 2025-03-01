# 🔠 String

**`#bs.string:help`**

Manage strings (text), allowing easy transformation and searching within the text

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Concat

```{function} #bs.string:concat

Merge a list of strings together into one string

:Inputs:
  **Storage `bs:in string.concat.list`**: {nbt}`string` The list of strings that will be merge.

:Outputs:
  **Storage `bs:out string.concat`**: {nbt}`string` The merge string.
```

_Merge `Hello` and `World`:_

```mcfunction
data modify storage bs:in string.concat.list set value ["Hello ","World"]

function #bs.string:concat

tellraw @a [{"text":"The merge string is \""},{"storage":"bs:out","nbt":"string.concat"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Uppercase / Lowercase

:::::{tab-set}
::::{tab-item} Upper

```{function} #bs.string:upper

Converts the text to uppercase

:Inputs:
  **Storage `bs:in string.upper.str`**: {nbt}`string` The string to convert to uppercase

:Outputs:
  **Strorage `bs:out string.upper`**: {nbt}`string` The uppercase string
```

_put `hello world` to uppercase:_

```mcfunction
data modify storage bs:in string.upper.str set value "hello world"

function #bs.string:upper

tellraw @a [{"text":"The uppercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```

::::
::::{tab-item} Lower

```{function} #bs.string:lower

Converts the text to lowercase

:Inputs:
  **Storage `bs:in string.lower.str`**: {nbt}`string` The string to convert to lowercase

:Outputs:
  **Strorage `bs:out string.lower`**: {nbt}`string` The lowercase string
```

_put `hello world` to lowercase:_

```mcfunction
data modify storage bs:in string.lower.str set value "hello world"

function #bs.string:lower

tellraw @a [{"text":"The lowercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```

::::
:::::

> **Credits**: Aure31

---

### Replace

```{function} #bs.string:replace

Replace a string by another

:Inputs:
  **Storage `bs:in string.replace.str`**: {nbt}`string` The string to replace

  **Storage `bs:in string.replace.old`**: {nbt}`string` The string to replace

  **Storage `bs:in string.replace.new`**: {nbt}`string` The string to replace by

:Outputs:
  **Strorage `bs:out string.replace`**: {nbt}`string` The replaced string
```

_replace world by minecraft:_

```mcfunction
data modify storage bs:in string.replace.str set value "hello world"
data modify storage bs:in string.replace.old set value "world"
data modify storage bs:in string.replace.new set value "minecraft"

function #bs.string:replace {type:'fast'}

tellraw @a [{"text":"The new string is \""},{"storage":"bs:out","nbt":"string.replace"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Find

```{function} #bs.string:find {occurrence:<int>}

Find a string in another string

:Inputs:
  **Storage `bs:in string.find.str`**: {nbt}`string` The string to find

  **Storage `bs:in string.find.needle`**: {nbt}`string` The string to find

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **occurrence**: The number of occurrence to find (if 0, find all)
  :::

:Outputs:
  **Strorage `bs:out string.find`**: {nbt}`list` The list of index where the string is found
```

_find `world` in `hello world`:_

```mcfunction
data modify storage bs:in string.find.str set value "hello world"
data modify storage bs:in string.find.needle set value "world"

function #bs.string:find {occurrence:0}

tellraw @a [{"text":"The string is found at index \""},{"storage":"bs:out","nbt":"string.find"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Insert

```{function} #bs.string:insert {index:<int>}

Insert a string in another string

:Inputs:
  **Storage `bs:in string.insert.str`**: {nbt}`string` The string to insert in

  **Storage `bs:in string.insert.needle`**: {nbt}`string` The string to insert

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **index**: The index where to insert the string
  :::

:Outputs:
  **Strorage `bs:out string.insert`**: {nbt}`string` The new string
```

_insert `beautiful` in `hello world`:_

```mcfunction
data modify storage bs:in string.insert.str set value "hello world"
data modify storage bs:in string.insert.needle set value "beautiful"

function #bs.string:insert {index:6}

tellraw @a [{"text":"The new string is \""},{"storage":"bs:out","nbt":"string.insert"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Split

```{function} #bs.string:split {maxsplit:<int>}

Split a string into a list of strings

:Inputs:
  **Storage `bs:in string.split.str`**: {nbt}`string` The string to split

  **Storage `bs:in string.split.separator`**: {nbt}`string` The separator to split the string

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **maxsplit**: The maximum number of split to do (if 0, split all)
  :::

:Outputs:
  **Strorage `bs:out string.split`**: {nbt}`list` The list of strings
```

_split `hello world` by `" "`:_

```mcfunction
data modify storage bs:in string.split.str set value "hello world"
data modify storage bs:in string.split.separator set value " "

function #bs.string:split {maxsplit:0}

tellraw @a [{"text":"The list of strings is \""},{"storage":"bs:out","nbt":"string.split"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Transform Type

::::{tab-set}
:::{tab-item} To List

```{function} #bs.string:to_list

Transform a string into a list of characters

:Inputs:
  **Storage `bs:in string.to_list.str`**: {nbt}`string` The string to transform

:Outputs:
  **Strorage `bs:out string.to_list`**: {nbt}`list` The list of characters
```

_transform `hello world` into a list:_

```mcfunction
data modify storage bs:in string.to_list.str set value "hello world"

function #bs.string:to_list

tellraw @a [{"text":"The list of characters is \""},{"storage":"bs:out","nbt":"string.to_list"},{"text":"\""}]
```

:::
:::{tab-item} To String

```{function} #bs.string:to_string

Transform a number into a string

:Inputs:
  **Macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **number**: The number to transform
  :::

:Outputs:
  **Strorage `bs:out string.to_string`**: {nbt}`string` The string
```

_transform 42 into a string:_

```mcfunction
function #bs.string:to_string {number:42}

tellraw @a [{"text":"The string is \""},{"storage":"bs:out","nbt":"string.to_string"},{"text":"\""}]
```

:::

::::

> **Credits**: Aure31

---
