# 🔠 String

**`#bs.string:help`**

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Concat

```{function} #bs.string:concat

Merges a list of strings together into one string

:Inputs:
  **Storage `bs:in string.concat.list`**: {nbt}`string` The list of strings that will be merged.

:Outputs:
  **Storage `bs:out string.concat`**: {nbt}`string` The merged string.
```

_Merged Hello and World:_

```mcfunction
data modify storage bs:in string.concat.list set value ["Hello ","World"]

function #bs.string:concat

tellraw @a [{"text":"The merged string is \""},{"storage":"bs:out","nbt":"string.concat"},{"text":"\""}]
```

> **Credits**: Aure31

---

### Uppercase / Lowercase

:::::{tab-set}
::::{tab-item} Upper

```{function} #bs.string:upper {type:<mode>}

Converts the text to uppercase

:Inputs:
  **Storage `bs:in string.upper.str`**: {nbt}`string` The string to convert to uppercase

  **Function Macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
   - {nbt}`string` **type** : the size of the character table (`fast` or `slow`)
  :::

:Outputs:
  **Strorage `bs:out string.upper`**: {nbt}`string` The uppercase string
```

_put hello world to uppercase:_

```mcfunction
data modify storage bs:in string.upper.str set value "hello world"

function #bs.string:upper {type:'fast'}

tellraw @a [{"text":"The uppercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```

::::
::::{tab-item} Lower

```{function} #bs.string:lower {type:<mode>}

Converts the text to lowercase

:Inputs:
  **Storage `bs:in string.lower.str`**: {nbt}`string` The string to convert to lowercase

  **Function Macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
   - {nbt}`string` **type** : the size of the character table (`fast` or `slow`)
  :::

:Outputs:
  **Strorage `bs:out string.lower`**: {nbt}`string` The lowercase string
```

_put hello world to lowercase:_

```mcfunction
data modify storage bs:in string.lower.str set value "hello world"

function #bs.string:lower {type:'fast'}

tellraw @a [{"text":"The lowercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```
