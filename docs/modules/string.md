# 🔠 String

**`#bs.string:help`**

Manage strings (text), allowing easy transformation and searching within the text.

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Concat

```{function} #bs.string:concat

Merge multiple strings from the input list into a single string.

:Inputs:
  **Storage `bs:in string.concat.list`**: {nbt}`string` List of strings to merge

:Outputs:
  **Storage `bs:out string.concat`**: {nbt}`string` The merged string
```

_Merge `Hello ` and `World`:_

```mcfunction
data modify storage bs:in string.concat.list set value ["Hello ","World"]
function #bs.string:concat
tellraw @a [{"text":"The merged string is \""},{"storage":"bs:out","nbt":"string.concat"},{"text":"\""}]
```

```{admonition} Technical Limitation
:class: warning

If you want to use double quotes (") in a string, you need to escape them: "\"".

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

_Convert `hello world` to its uppercase version `HELLO WORLD`:_

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

_Convert `HELLO WORLD` to its lowercase version `hello world`:_

```mcfunction
data modify storage bs:in string.lower.str set value "HELLO WORLD"
function #bs.string:lower
tellraw @a [{"text":"The lowercase string is \""},{"storage":"bs:out","nbt":"string.lower"},{"text":"\""}]
```

::::
:::::

```{admonition} Support
:class: hint

This function actually supports all UTF-8 characters.

```

```{admonition} Technical Limitation
:class: warning

this functions just don't support using `"`.

```

> **Credits**: Aure31

---

### Find

:::::{tab-set}
::::{tab-item} Find all

```{function} #bs.string:find_all

Search for a substring within a string. Locate all occurrences or a specific number of matches.

:Inputs:
  **Storage `bs:in string.find_all`**:
  :::{treeview}
  - {nbt}`compound` Find data
    - {nbt}`string` **str**: String to search in.
    - {nbt}`string` **substr**: String to find.
    - {nbt}`int` **occurrence**: Number of occurrences to find (-1 or less for all occurrences).
  :::

:Outputs:
  **Storage `bs:out string.find_all`**: {nbt}`list` List of indices where the substring was found.

  **Return**: Number of occurrences found.
```

_Find `world` in `hello world world`:_

```mcfunction
data modify storage bs:in string.find set value {str:"hello world",substr:"world",occurrence:-1}
function #bs.string:find_all
tellraw @a [{"text":"Found at indices: \""},{"storage":"bs:out","nbt":"string.find"},{"text":"\""}]
# return [6,12]
```

::::
::::{tab-item} Find first

```{function} #bs.string:find

Search for a substring within a string. Locate the first occurrence.

:Inputs:
  **Storage `bs:in string.find`**:
  :::{treeview}
  - {nbt}`compound` Find data
    - {nbt}`string` **str**: String to search in.
    - {nbt}`string` **substr**: String to find.
  :::

:Outputs:
  **Return**: Index of the first occurrence or -1 if not found.

```
_Find `world` in `hello world`:_

```mcfunction
data modify storage bs:in string.find set value {str:"hello world",substr:"world"}
execute store result score #c bs.ctx run function #bs.string:find
tellraw @a [{"text":"Found at index: \""},{"score":{"name":"#c","objective":"bs.ctx"}},{"text":"\""}]
# return 6
```
::::
:::::

```{admonition} Technical Limitation
:class: warning

this functions just don't support using `"`.

```

> **Credits**: Aure31

---

### Replace

```{function} #bs.string:replace

Replace occurrences of a substring by a new text.

:Inputs:
  **Storage `bs:in string.replace`**:
  :::{treeview}
  - {nbt}`compound` Replace data
    - {nbt}`string` **str**: Base string for replacements.
    - {nbt}`string` **old**: Substring to replace.
    - {nbt}`string` **new**: Replacement string.
    - {nbt}`int` **maxreplace**: Maximum replacements. (-1 or less for unlimited)
  :::

:Outputs:
  **Storage `bs:out string.replace`**: {nbt}`string` String after replacements.
```

_Replace `world` with `minecraft`:_

```mcfunction
data modify storage bs:in string.replace set value {str:"hello world",old:"world",new:"minecraft",maxreplace:-1}
function #bs.string:replace
tellraw @a [{"text":"Result: \""},{"storage":"bs:out","nbt":"string.replace"},{"text":"\""}]
# return "hello minecraft"
```

```{admonition} Technical Limitation
:class: warning

this functions just don't support using `"`.

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

_replace the space in `hello world` by ` beautiful `:_

```mcfunction
data modify storage bs:in string.replace_range set value {str:"hello world",substr:" beautiful ",start:5,end:6}
function #bs.string:replace_range
tellraw @a [{"text":"The new string is \""},{"storage":"bs:out","nbt":"string.replace_range"},{"text":"\""}]
# return "hello beautiful world"
```

```{admonition} Use as Insert
:class: tip
To insert text without removing any characters, set both `start` and `end` to the same position. This will insert the new text at that position while preserving all existing characters.
```

```{admonition} Technical Limitation
:class: warning

If you want to use double quotes (") in a string, you need to escape them: "\"".

```

> **Credits**: Aure31

---

### Reverse

```{function} #bs.string:reverse

Reverse the order of all characters in a string. For example, "hello" become "olleh".

:Inputs:
  **Storage `bs:in string.reverse.str`**: {nbt}`string` The string to be reversed.

:Outputs:
  **Storage `bs:out string.reverse`**: {nbt}`string` The string with all characters in reverse order.
```

_reverse `hello world`:_

```mcfunction
data modify storage bs:in string.reverse.str set value "hello world"
function #bs.string:reverse
tellraw @a [{"text":"The reversed string is \""},{"storage":"bs:out","nbt":"string.reverse"},{"text":"\""}]
# return "dlrow olleh"
```

```{admonition} Technical Limitation
:class: warning

this functions just don't support using `"`.

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
    - {nbt}`int` **maxsplit**: Maximum number of splits to perform (-1 or less for unlimited).
  :::

:Outputs:
  **Storage `bs:out string.split`**: {nbt}`list` A list containing all the split parts of the original string.
```

_split `hello world` by `" "`:_

```mcfunction
data modify storage bs:in string.split set value {str:"hello world",separator:" ",maxsplit:-1}
function #bs.string:split
tellraw @a [{"text":"The list of strings is \""},{"storage":"bs:out","nbt":"string.split"},{"text":"\""}]
# returns "["hello","world"]"
```

```{admonition} Technical Limitation
:class: warning

this function just don't support using `"`.

```

> **Credits**: Aure31

---

### Transform Type

:::::{tab-set}
::::{tab-item} To List

```{function} #bs.string:to_list

Convert a string into a list where each character becomes a separate element.

:Inputs:
  **Storage `bs:in string.to_list.str`**: {nbt}`string` The string to convert into a character list.

:Outputs:
  **Storage `bs:out string.to_list`**: {nbt}`list` A list containing each character as a separate element.
```

_transform `hello world` into a list:_

```mcfunction
data modify storage bs:in string.to_list.str set value "hello world"
function #bs.string:to_list
tellraw @a [{"text":"The list of characters is \""},{"storage":"bs:out","nbt":"string.to_list"},{"text":"\""}]
# returns ["h","e","l","l","o"," ","w","o","r","l","d"]
```

::::
::::{tab-item} To String

```{function} #bs.string:to_string

Convert any value into its string representation.

:Inputs:
  **Storage `bs:in string.to_string.val`**: {nbt}`any` The value to convert into a string.

:Outputs:
  **Storage `bs:out string.to_string`**: {nbt}`string` The value converted to its string representation.
```

_transform `42` into a string:_

```mcfunction
data modify storage bs:in string.to_string.number set value 42
function #bs.string:to_string
tellraw @a [{"text":"The string is \""},{"storage":"bs:out","nbt":"string.to_string"},{"text":"\""}]
```

::::
::::{tab-item} Parse

```{function} #bs.string:parse

Try to convert the string into the value it represents.

:Inputs:
  **Storage `bs:in string.parse.str`**: {nbt}`string` The string containing the number to be extracted.

:Outputs:
  **Storage `bs:out string.parse`**: {nbt}`any` The extracted value (ex: "true" -> boolean, "42" -> int, "42.0" -> double).
```

_transform `"42"` into a integer:_

```mcfunction
data modify storage bs:in string.parse.str set value "42"
function #bs.string:parse
tellraw @a [{"text":"The number is \""},{"storage":"bs:out","nbt":"string.parse"},{"text":"\""}]
```

::::
:::::

```{admonition} Technical Limitation
:class: warning

this functions just don't support using `"`.

```

> **Credits**: Aure31
