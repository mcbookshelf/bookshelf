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

```{function} #bs.string:upper {type:<mode>}

Converts the text to uppercase

:Inputs:
  **Storage `bs:in string.upper.str`**: {nbt}`string` The string to convert to uppercase

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

:Outputs:
  **Strorage `bs:out string.lower`**: {nbt}`string` The lowercase string
```

_put hello world to lowercase:_

```mcfunction
data modify storage bs:in string.lower.str set value "hello world"

function #bs.string:lower {type:'fast'}

tellraw @a [{"text":"The lowercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```
