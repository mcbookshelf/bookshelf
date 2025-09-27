# 🔠 String

**`#bs.string:help`**

Manage and transform strings with a versatile set of manipulation and search functions.

```{image} /_imgs/modules/string.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"Words are the most powerful drug used by mankind."

-- Rudyard Kipling
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Concat

```{function} #bs.string:concat

Merge multiple strings from an array into a single concatenated string.

:Inputs:
  **Storage `bs:in string.concat.list`**: {nbt}`list` List of strings to concatenate.

:Outputs:
  **Storage `bs:out string.concat`**: {nbt}`string` The concatenated string.
```

*Example: Concatenate `Hello `, and `World` then display the result:*

```mcfunction
data modify storage bs:in string.concat.list set value ["Hello ","World"]
function #bs.string:concat
tellraw @a [{"text":"The merged string is \""},{"storage":"bs:out","nbt":"string.concat"},{"text":"\""}]
```

```{admonition} Technical Limitation
:class: warning

If you want to use double quotes (`"`) within a string, you must escape them with a backslash: `\"`.
```

> **Credits**: Aure31

---

### Convert Case

:::::{tab-set}
::::{tab-item} Uppercase

```{function} #bs.string:upper

Convert text to uppercase.

:Inputs:
  **Storage `bs:in string.upper.str`**: {nbt}`string` The string to convert to uppercase.

:Outputs:
  **Storage `bs:out string.upper`**: {nbt}`string` The uppercase string.
```

*Example: Convert `hello world` to `HELLO WORLD` then display the result:*

```mcfunction
data modify storage bs:in string.upper.str set value "hello world"
function #bs.string:upper
tellraw @a [{"text":"The uppercase string is \""},{"storage":"bs:out","nbt":"string.upper"},{"text":"\""}]
```

::::
::::{tab-item} Lowercase

```{function} #bs.string:lower

Convert text to lowercase.

:Inputs:
  **Storage `bs:in string.lower.str`**: {nbt}`string` The string to convert to lowercase.

:Outputs:
  **Storage `bs:out string.lower`**: {nbt}`string` The lowercase string.
```

*Example: Convert `HELLO WORLD` to `hello world` then display the result:*

```mcfunction
data modify storage bs:in string.lower.str set value "HELLO WORLD"
function #bs.string:lower
tellraw @a [{"text":"The lowercase string is \""},{"storage":"bs:out","nbt":"string.lower"},{"text":"\""}]
```

::::
:::::

```{admonition} Technical Limitation
:class: warning

These functions support most UTF-8 characters, but they do not support the double quote character (`"`). Attempts to use or escape double quotes will result in errors.

```

> **Credits**: Aure31

---

### Find

:::::{tab-set}
::::{tab-item} Find

```{function} #bs.string:find

Search for a substring within a string. Find the first occurrence.

:Inputs:
  **Storage `bs:in string.find`**:
  :::{treeview}
  - {nbt}`compound` Find data
    - {nbt}`string` **str**: String to search in.
    - {nbt}`string` **substr**: Substring to search for.
  :::

:Outputs:
  **Return**: Integer index of the first occurrence or -1 if not found.

```
*Example: Find the first occurrence of `world` in `hello world` then display the index:*

```mcfunction
data modify storage bs:in string.find set value {str:"hello world",substr:"world"}
execute store result score #c bs.ctx run function #bs.string:find
# return 6
tellraw @a [{"text":"Found at index: \""},{"score":{"name":"#c","objective":"bs.ctx"}},{"text":"\""}]
```
::::
::::{tab-item} Find all

```{function} #bs.string:find_all

Search for a substring within a string. Find all occurrences or a specific number of matches.

:Inputs:
  **Storage `bs:in string.find_all`**:
  :::{treeview}
  - {nbt}`compound` Find data
    - {nbt}`string` **str**: String to search in.
    - {nbt}`string` **substr**: Substring to search for.
    - {nbt}`int` **occurrence**: Number of occurrences to find (-1 for all occurrences).
  :::

:Outputs:
  **Storage `bs:out string.find_all`**: {nbt}`list` List of indices where the substring was found, in order of occurrence.

  **Return**: Number of occurrences found.
```

*Example: Find all occurrences of `world` in `hello world world` then display the indices:*

```mcfunction
data modify storage bs:in string.find set value {str:"hello world",substr:"world",occurrence:-1}
function #bs.string:find_all
# return [6,12]
tellraw @a [{"text":"Found at indices: \""},{"storage":"bs:out","nbt":"string.find"},{"text":"\""}]
```

::::
:::::

```{admonition} Technical Limitation
:class: warning

These functions do not support the double quote character (`"`). Attempts to use or escape double quotes will result in errors.

```

> **Credits**: Aure31

---

### Replace

```{function} #bs.string:replace

Replace occurrences of a substring with a new text.

:Inputs:
  **Storage `bs:in string.replace`**:
  :::{treeview}
  - {nbt}`compound` Replace data
    - {nbt}`string` **str**: Base string for replacements.
    - {nbt}`string` **old**: Substring to replace.
    - {nbt}`string` **new**: Replacement string.
    - {nbt}`int` **maxreplace**: Maximum replacements. (-1 for unlimited)
  :::

:Outputs:
  **Storage `bs:out string.replace`**: {nbt}`string` String after replacements.
```

*Example: Replace `world` with `minecraft` in `hello world` then display the result::*

```mcfunction
data modify storage bs:in string.replace set value {str:"hello world",old:"world",new:"minecraft",maxreplace:-1}
function #bs.string:replace
# return "hello minecraft"
tellraw @a [{"text":"Result: \""},{"storage":"bs:out","nbt":"string.replace"},{"text":"\""}]
```

```{admonition} Technical Limitation
:class: warning

This function do not support the double quote character (`"`). Attempts to use or escape double quotes will result in errors.

```

> **Credits**: Aure31

---

### Replace Range

```{function} #bs.string:replace_range

Replace characters in a string between specified start and end positions with a new substring.

:Inputs:
  **Storage `bs:in string.replace_range`**:
  :::{treeview}
  - {nbt}`compound` Replace range data
    - {nbt}`string` **str**: The original string to modify.
    - {nbt}`string` **substr**: The new string to insert between start and end positions.
    - {nbt}`int` **start**: Starting position in the original string (inclusive).
    - {nbt}`int` **end**: Ending position in the original string (exclusive).
  :::

:Outputs:
  **Storage `bs:out string.replace_range`**: {nbt}`string` The modified string with the specified range replaced.
```

*Example: Replace the space in `hello world` with ` beautiful ` then display the result:*

```mcfunction
data modify storage bs:in string.replace_range set value {str:"hello world",substr:" beautiful ",start:5,end:6}
function #bs.string:replace_range
# return "hello beautiful world"
tellraw @a [{"text":"The new string is \""},{"storage":"bs:out","nbt":"string.replace_range"},{"text":"\""}]
```

```{admonition} How to Insert?
:class: tip

To insert text without removing any characters, set both `start` and `end` to the same position. This will insert the new text at that position while preserving all existing characters.
```

```{admonition} Technical Limitation
:class: warning

If you want to use double quotes (`"`) within a string, you must escape them with a backslash: `\"`.
```

> **Credits**: Aure31

---

### Reverse

```{function} #bs.string:reverse

Reverse the order of all characters in a string.

:Inputs:
  **Storage `bs:in string.reverse.str`**: {nbt}`string` The string to reverse.

:Outputs:
  **Storage `bs:out string.reverse`**: {nbt}`string` The string with all characters in reverse order.
```

*Example: Reverse `hello world` then display the result:*

```mcfunction
data modify storage bs:in string.reverse.str set value "hello world"
function #bs.string:reverse
# return "dlrow olleh"
tellraw @a [{"text":"The reversed string is \""},{"storage":"bs:out","nbt":"string.reverse"},{"text":"\""}]
```

```{admonition} Technical Limitation
:class: warning

This function do not support the double quote character (`"`). Attempts to use or escape double quotes will result in errors.

```

> **Credits**: Aure31

---

### Split

```{function} #bs.string:split

Divide a string into smaller parts using a specified separator, creating a list of substrings.

:Inputs:
  **Storage `bs:in string.split`**:
  :::{treeview}
  - {nbt}`compound` Split data
    - {nbt}`string` **str**: The string to be split into parts.
    - {nbt}`string` **separator**: The character or string that marks where to split.
    - {nbt}`int` **maxsplit**: Maximum number of splits to perform (-1 for unlimited).
  :::

:Outputs:
  **Storage `bs:out string.split`**: {nbt}`list` A list containing the split parts of the original string, in the order they appear.
```

*Example: Split `hello world` by `" "` then display the result:*

```mcfunction
data modify storage bs:in string.split set value {str:"hello world",separator:" ",maxsplit:-1}
function #bs.string:split
# return "["hello","world"]"
tellraw @a [{"text":"The list of strings is \""},{"storage":"bs:out","nbt":"string.split"},{"text":"\""}]

```

```{admonition} Technical Limitation
:class: warning

This function do not support the double quote character (`"`). Attempts to use or escape double quotes will result in errors.

```

> **Credits**: Aure31

---

### Transform Type

:::::{tab-set}
::::{tab-item} Parse

```{function} #bs.string:parse

Attempt to convert the string into its corresponding value.

:Inputs:
  **Storage `bs:in string.parse.str`**: {nbt}`string` The string containing the value to be extracted.

:Outputs:
  **Storage `bs:out string.parse`**: {nbt}`any` The extracted value. Possible types: boolean, integer, double, string.
```

*Example: Transform `"42"` into an integer then display the result:*

```mcfunction
data modify storage bs:in string.parse.str set value "42"
function #bs.string:parse
tellraw @a [{"text":"The number is \""},{"storage":"bs:out","nbt":"string.parse"},{"text":"\""}]
```

::::
::::{tab-item} To List

```{function} #bs.string:to_list

Convert a string into a list where each character becomes a separate element.

:Inputs:
  **Storage `bs:in string.to_list.str`**: {nbt}`string` The string to convert into a character list.

:Outputs:
  **Storage `bs:out string.to_list`**: {nbt}`list` A list containing each character as a separate element.
```

*Example: Transform `hello world` into a character list then display the result:*

```mcfunction
data modify storage bs:in string.to_list.str set value "hello world"
function #bs.string:to_list
# return ["h","e","l","l","o"," ","w","o","r","l","d"]
tellraw @a [{"text":"The list of characters is \""},{"storage":"bs:out","nbt":"string.to_list"},{"text":"\""}]
```

::::
::::{tab-item} To String

```{function} #bs.string:to_string

Convert any value into its string representation.

:Inputs:
  **Storage `bs:in string.to_string.value`**: {nbt}`any` The value to convert into a string.

:Outputs:
  **Storage `bs:out string.to_string`**: {nbt}`string` The value converted to its string representation.
```

*Example: Transform `42` into its string representation then display the result:*

```mcfunction
data modify storage bs:in string.to_string.number set value 42
function #bs.string:to_string
tellraw @a [{"text":"The string is \""},{"storage":"bs:out","nbt":"string.to_string"},{"text":"\""}]
```

::::
:::::

> **Credits**: Aure31

---

```{include} ../_templates/comments.md
```
