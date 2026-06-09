# 🗂️ Collection

**`#bs.collection:help`**

Functional programming operations for working with collections in Minecraft.
This module is NOT a stream module, features are not lazy.

```{image} /_imgs/modules/collection-light.png
:align: center
:class: only-light p-2
```

```{image} /_imgs/modules/collection-dark.png
:align: center
:class: only-dark p-2
```

```{pull-quote}
"It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures."

-- Alan Perlis
```

---

## 🔧 Functions

You can find below all functions available in this module.

```{admonition} Input and Output
:class: info

Unlike most Bookshelf modules, collection features typically read their input from `bs:out` instead of `bs:in`.
This design facilitates operation chaining, as the output of one function immediately becomes the input for the next.
```

---

### Drop

Operations that remove elements from the start of a collection.

:::::{tab-set}
::::{tab-item} Drop

```{function} #bs.collection:drop {number:<value>}

Drop the first N elements from a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to drop from

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **number**: the number of elements to drop
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection with the first N elements removed
```

*Example: drop first 2 elements*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:drop {number: 2}
# bs:out collection.value = [3, 4, 5]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Drop While

```{function} #bs.collection:drop_while {run:<value>}

Drop elements from the beginning of a collection as long as a predicate is true.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to drop from

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the remaining elements

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) to continue dropping, fail (0) otherwise
```

*Example: drop elements until value is 3*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:drop_while {run: "execute unless data storage bs:lambda {collection: {value: 3}}"}
# bs:out collection.value = [3, 4, 5]
```

> **Credits**: theogiraudet

::::
:::::

---

### Filtering

Operations that select a subset of elements.

:::::{tab-set}
::::{tab-item} Distinct

```{function} #bs.collection:distinct

Remove duplicate elements from a collection, keeping only the first occurrence of each element.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to process

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection with duplicates removed
```

*Example: remove duplicates*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 2, 3, 1]
function #bs.collection:distinct
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Filter

```{function} #bs.collection:filter {run:<value>}

Keep only elements that satisfy a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to filter

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function to test each element
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the filtered collection containing only matching elements

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) to keep the element, fail (0) otherwise
```

*Example: keep only elements equal to 3*

```mcfunction
data modify storage bs:out collection.value set value [1, 3, 2, 3, 4]
function #bs.collection:filter {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = [3, 3]
```

> **Credits**: theogiraudet

::::
:::::

---

### Find

Operations that locate elements or their indices.

:::::{tab-set}
::::{tab-item} Find

```{function} #bs.collection:find {run:<value>}

Find the first element that satisfies a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to search

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection`**:
  :::{treeview}
  - {nbt}`compound` output data
    - {nbt}`any` **value**: the first matching element (removed if not found)
    - {nbt}`int` **index**: the index of the matching element, or -1 if not found
  :::

  **Return**: success if element found, fail otherwise

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

*Example: find the first element equal to "b"*

```mcfunction
data modify storage bs:out collection.value set value ["a", "b", "c"]
function #bs.collection:find {run: "execute if data storage bs:lambda collection{value: 'b'}"}
# bs:out collection.value = "b"
# bs:out collection.index = 1
```

> **Credits**: theogiraudet

::::
::::{tab-item} Find Last

```{function} #bs.collection:find_last {run:<value>}

Find the last element that satisfies a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to search

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection`**:
  :::{treeview}
  - {nbt}`compound` output data
    - {nbt}`any` **value**: the last matching element (removed if not found)
    - {nbt}`int` **index**: the index of the matching element, or -1 if not found
  :::

  **Return**: success if element found, fail otherwise

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

*Example: find the last element equal to 3*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 3
# bs:out collection.index = 4
```

> **Credits**: theogiraudet

::::
::::{tab-item} Index Of

```{function} #bs.collection:index_of {run:<value>}

Find the index of the first element matching a predicate.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to search

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the zero-based index of the first matching element, or -1

  **Return**: success if element found, fail otherwise

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

*Example: find the index of value 3*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
function #bs.collection:index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 2
```

> **Credits**: theogiraudet

::::
::::{tab-item} Last Index Of

```{function} #bs.collection:last_index_of {run:<value>}

Find the index of the last element matching a predicate.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to search

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the zero-based index of the last matching element, or -1

  **Return**: success if element found, fail otherwise

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

*Example: find the last index of value 3*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 4
```

> **Credits**: theogiraudet

::::
:::::

---

### Flattening

Operations that flatten nested collections.

:::::{tab-set}
::::{tab-item} Concat

```{function} #bs.collection:concat

Concatenate a list of lists into a single list. Functionally equivalent to `flatten`, provided as a semantic alias for when you think of the operation as concatenation rather than flattening.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` a list of lists to concatenate

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the flattened list containing all elements from the sub-lists in order
```

*Example: concatenate lists*

```mcfunction
data modify storage bs:out collection.value set value [[1, 2], [3], [4, 5]]
function #bs.collection:concat
# bs:out collection.value = [1, 2, 3, 4, 5]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Flatten

```{function} #bs.collection:flatten

Flatten a nested collection by one level.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the nested collection to flatten

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the flattened collection
```

*Example: flatten a 2D array*

```mcfunction
data modify storage bs:out collection.value set value [[1, 2], [3, 4], [5]]
function #bs.collection:flatten
# bs:out collection.value = [1, 2, 3, 4, 5]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Flatten Deep

```{function} #bs.collection:flatten_deep

Recursively flatten a nested collection of arbitrary depth. Preserves non-list elements.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the nested collection to flatten

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the deeply flattened collection
```

*Example: flatten a deeply nested structure*

```mcfunction
data modify storage bs:out collection.value set value [1, [2, 3], [[4], 5]]
function #bs.collection:flatten_deep
# bs:out collection.value = [1, 2, 3, 4, 5]
```

> **Credits**: theogiraudet

::::
:::::

---

### Fold

Reduce a collection to a single value using an explicit initial accumulator.

:::::{tab-set}
::::{tab-item} Fold

```{function} #bs.collection:fold {run:<value>,initial:<value>}

Reduce a collection to a single value by applying a function that combines the accumulator with each element, starting with a provided initial value.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to fold

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function that combines accumulator and value
    - {nbt}`any` **initial**: initial value for the accumulator, must be a valid NBT value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: the final accumulated value

  **Return**: 0 on success

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

*Example: fold with a custom function (see reduce for lambda details)*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:fold {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.value", initial: 0}
# bs:out collection.value = 3 (last element replaces accumulator each time)
```

> **Credits**: theogiraudet

::::
::::{tab-item} Fold Right

```{function} #bs.collection:fold_right {run:<value>,initial:<value>}

Reduce a collection to a single value by applying a function from right to left with a provided initial value.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to fold

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function that combines accumulator and value
    - {nbt}`any` **initial**: initial value for the accumulator, must be a valid NBT value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: the final accumulated value

  **Return**: 0 on success

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
:::::

---

### Generation

Operations that create new collections.

:::::{tab-set}
::::{tab-item} Generate

```{function} #bs.collection:generate {run:<value>,limit:<value>}

Generate a collection by repeatedly calling a generator function up to a limit.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: the command to execute to generate a value
    - {nbt}`int` **limit**: the number of values to generate
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the generated list

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`int` **index**: the current index being generated (0-based)
    - {nbt}`any` **result**: (output) the value generated by `run`
  :::
```

*Example: generate [0, 1, 2]*

```mcfunction
function #bs.collection:generate {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index", limit: 3}
# bs:out collection.value = [0, 1, 2]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Generate While

```{function} #bs.collection:generate_while {run:<value>,predicate:<value>}

Generate a collection by repeatedly calling a generator function while a predicate is met.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: the command to execute to generate a value
    - {nbt}`string` **predicate**: the predicate to check on the generated value, returns success to continue, fail to stop
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the generated list

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`int` **index**: the current index being generated (0-based)
    - {nbt}`any` **result**: (output) the value generated by `run`
  :::

:Lambda predicate:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the value generated by `run`
    - {nbt}`int` **index**: the current index being generated (0-based)
  :::

  **Return**: success to continue, fail to stop
```

*Example: generate values equal to index while the result is not 3*

```mcfunction
function #bs.collection:generate_while {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.index", predicate: "execute unless data storage bs:lambda {collection: {result: 3}}"}
# bs:out collection.value = [0, 1, 2]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Range

```{function} #bs.collection:range {min:<value>,max:<value>,step:<value>}

Generate a sequence of numbers from `min` (inclusive) to `max` (exclusive) with a specified `step`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **min**: the starting value (inclusive)
    - {nbt}`int` **max**: the ending value (exclusive)
    - {nbt}`int` **step**: the step between each value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the generated list of integers
```

*Example: generate 0, 1, 2, 3, 4*

```mcfunction
function #bs.collection:range {min: 0, max: 5, step: 1}
# bs:out collection.value = [0, 1, 2, 3, 4]

function #bs.collection:range {min: 0, max: 5, step: 2}
# bs:out collection.value = [0, 2, 4]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Repeat

```{function} #bs.collection:repeat {value:<value>,count:<value>}

Create a collection containing `count` copies of `value`.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`any` **value**: the value to repeat (must be a valid NBT value)
    - {nbt}`int` **count**: the number of times to repeat the value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the generated list
```

*Example: repeat a value 3 times*

```mcfunction
function #bs.collection:repeat {value: 5, count: 3}
# bs:out collection.value = [5, 5, 5]
```

```{admonition} Repeat Strings
:class: warning

To repeat a string, the value must be double quoted (e.g. "'Hello'").
```

> **Credits**: theogiraudet

::::
:::::

---

### Iteration

Run a lambda over each element for its side effects.

:::::{tab-set}
::::{tab-item} For Each

```{function} #bs.collection:for_each {run:<value>}

Execute an operation on each element of a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to iterate over

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function to execute on each element
  :::

:Outputs:
  None. This function is used for side effects only.

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::
```

*Example: display each element*

```mcfunction
data modify storage bs:out collection.value set value ["Hello", "World", "!"]
function #bs.collection:for_each {run: "tellraw @a [{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# Displays each string to all players
```

> **Credits**: theogiraudet

::::
:::::

---

### Mapping

Operations that transform each element.

:::::{tab-set}
::::{tab-item} Flat Map

```{function} #bs.collection:flat_map {run:<value>}

Transform each element into a collection and flatten the results into a single collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to transform

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function to execute on each element
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the flattened transformed collection

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
    - {nbt}`list` **result**: (output) the list of values to flatten into the result
  :::
```

*Example: transform each number into a list of its multiples and flatten*

```mcfunction
# This would require a custom function that returns a list
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:flat_map {run: "function mypack:get_multiples"}
# If get_multiples returns [n, n*2] for each n, result would be [1, 2, 2, 4, 3, 6]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Map

```{function} #bs.collection:map {run:<value>}

Transform each element of a collection using a lambda function.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to transform

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function to execute on each element
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the transformed collection

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
    - {nbt}`any` **result**: (output) the transformed value for the element
  :::
```

*Example: double each number in a list*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:map {run: "execute store result storage bs:lambda collection.result int 2 run data get storage bs:lambda collection.value"}
# bs:out collection.value = [2, 4, 6, 8, 10]
```

> **Credits**: theogiraudet

::::
:::::

---

### Numeric Aggregation

Operations that compute a single numeric result from a collection.

:::::{tab-set}
::::{tab-item} Average

```{function} #bs.collection:iaverage {scale:<value>}

Calculate the average (mean) of a collection of numbers (integers).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection of numbers

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **scale**: scale factor applied to the return value (e.g. 1000 to get 3 decimal places of precision)
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`double` the average (unscaled)

  **Return**: the average multiplied by `scale` as an integer
```

*Example: average of [1, 2, 3, 4, 5]*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:iaverage {scale: 1000}
# bs:out collection.value = 3.0d
# Return value = 3000
```

> **Credits**: theogiraudet

::::
::::{tab-item} Count

```{function} #bs.collection:count

Count the number of elements in a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to count

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the number of elements

  **Return**: integer count of elements in the collection
```

*Example: count elements*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:count
# bs:out collection.value = 5
```

> **Credits**: theogiraudet

::::
::::{tab-item} Max

```{function} #bs.collection:imax

Find the maximum value in a collection of integers.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection of integers

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the maximum value
```

> **Credits**: theogiraudet

::::
::::{tab-item} Min

```{function} #bs.collection:imin

Find the minimum value in a collection of integers.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection of integers

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the minimum value
```

> **Credits**: theogiraudet

::::
::::{tab-item} Sum

```{function} #bs.collection:isum

Calculate the sum of all numbers in a collection (integers).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection of numbers

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` the sum
```

> **Credits**: theogiraudet

::::
:::::

---

### Partition

Split a collection into two based on a predicate.

:::::{tab-set}
::::{tab-item} Partition

```{function} #bs.collection:partition {run:<value>}

Split a collection into two collections based on a predicate: one containing elements that match the predicate, and one containing elements that don't.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to partition

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function to test each element
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` a list containing two lists: `[matches, non_matches]`

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

*Example: partition even and odd numbers*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
# Assume is_even returns 1 for even numbers, 0 for odd
function #bs.collection:partition {run: "function mypack:is_even"}
# bs:out collection.value = [[2, 4], [1, 3, 5]]
```

> **Credits**: theogiraudet

::::
:::::

---

### Peek

Run a lambda on each element while passing the collection through unchanged.

:::::{tab-set}
::::{tab-item} Peek

```{function} #bs.collection:peek {run:<value>}

Execute an operation on each element of a collection and return the original collection. Useful for debugging or side effects in a chain of operations.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to iterate over

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function to execute on each element
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the original collection, unchanged

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::
```

*Example: log elements while processing*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
# Log each element then continue with other operations
function #bs.collection:peek {run: "tellraw @a [{\"text\":\"Processing: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
:::::

---

### Predicates

Operations that test a collection and return success or failure.

:::::{tab-set}
::::{tab-item} All

```{function} #bs.collection:all {run:<value>}

Test if all elements satisfy a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to test

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Return**: success (1) if all elements match

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

> **Credits**: theogiraudet

::::
::::{tab-item} Any

```{function} #bs.collection:any {run:<value>}

Test if at least one element satisfies a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to test

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Return**: success (1) if any element matches

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

> **Credits**: theogiraudet

::::
::::{tab-item} Contains

```{function} #bs.collection:contains {searched:<value>}

Check if a collection contains a specific value.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to search

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`any` **searched**: the value to search for
  :::

:Outputs:
  **Return**: success (1) if found, fail (0) otherwise
```

> **Credits**: theogiraudet

::::
::::{tab-item} Is Empty

```{function} #bs.collection:is_empty

Test if a collection is empty.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to test

:Outputs:
  **Return**: success (1) if empty
```

> **Credits**: theogiraudet

::::
::::{tab-item} None

```{function} #bs.collection:none {run:<value>}

Test if no elements satisfy a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to test

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Return**: success (1) if no elements match

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) for match, fail (0) otherwise
```

> **Credits**: theogiraudet

::::
:::::

---

### Reduce

Reduce a collection to a single value, using the first element as the initial accumulator.

:::::{tab-set}
::::{tab-item} Reduce

```{function} #bs.collection:reduce {run:<value>}

Reduce a collection to a single value by applying a function that combines the accumulator with each element.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to reduce

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function that combines accumulator and value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: the final accumulated value

  **Return**: 0 on success, fail if the collection is empty

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

*Example: get the last element using reduce*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reduce {run: "data modify storage bs:lambda collection.result set from storage bs:lambda collection.value"}
# bs:out collection.value = 5
```

> **Credits**: theogiraudet

::::
::::{tab-item} Reduce Right

```{function} #bs.collection:reduce_right {run:<value>}

Reduce a collection to a single value by applying a function from right to left, starting with the last element as the initial accumulator.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to reduce

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function that combines accumulator and value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: the final accumulated value

  **Return**: 0 on success, fail if the collection is empty

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
:::::

---

### Reverse

Reverse the order of elements.

:::::{tab-set}
::::{tab-item} Reverse

```{function} #bs.collection:reverse

Reverse the order of elements in a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to reverse

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection with elements in reversed order
```

*Example: reverse a list*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reverse
# bs:out collection.value = [5, 4, 3, 2, 1]
```

> **Credits**: theogiraudet

::::
:::::

---

### Scale

Multiply every number in a collection by a factor.

:::::{tab-set}
::::{tab-item} Scale

```{function} #bs.collection:scale {scale:<value>}

Multiply all numbers in a collection by a scaling factor.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection of numbers to scale

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`float` **scale**: the scaling factor (multiplier)
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection with all values multiplied by the scale
```

*Example: multiply all elements by 10*

```mcfunction
data modify storage bs:out collection.value set value [1.5d, 2.5d]
function #bs.collection:scale {scale: 10}
# bs:out collection.value = [15.0d, 25.0d]
```

> **Credits**: theogiraudet

::::
:::::

---

### Scan

```{admonition} Naming Convention
:class: tip

`scan_reduce` and `scan_fold` mirror `reduce` and `fold`, but return every
intermediate accumulator value instead of only the final one. The `_right`
suffix indicates right-to-left processing.
```

:::::{tab-set}
::::{tab-item} Scan Fold

```{function} #bs.collection:scan_fold {run:<value>,initial:<value>}

Similar to `fold`, but returns a list of all intermediate accumulator values.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to scan

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function
    - {nbt}`any` **initial**: initial value, must be a valid NBT value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the list of intermediate results

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
::::{tab-item} Scan Fold Right

```{function} #bs.collection:scan_fold_right {run:<value>,initial:<value>}

Similar to `fold_right`, but returns a list of all intermediate accumulator values.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to scan

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function
    - {nbt}`any` **initial**: initial value, must be a valid NBT value
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the list of intermediate results

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
::::{tab-item} Scan Reduce

```{function} #bs.collection:scan_reduce {run:<value>}

Similar to `reduce`, but returns a list of all intermediate accumulator values.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to scan

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the list of intermediate results

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
::::{tab-item} Scan Reduce Right

```{function} #bs.collection:scan_reduce_right {run:<value>}

Similar to `reduce_right`, but returns a list of all intermediate accumulator values.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to scan

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the list of intermediate results

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **accumulator**: (input) the current accumulated value
    - {nbt}`any` **value**: (input) the current element being processed
    - {nbt}`int` **index**: (input) the zero-based index of the current element
    - {nbt}`any` **result**: (output) the new accumulated value
  :::
```

> **Credits**: theogiraudet

::::
:::::

---

### Set Operations

Operations treating collections as sets.

:::::{tab-set}
::::{tab-item} Difference

```{function} #bs.collection:difference

Compute the difference of two collections (elements present in the first collection but not in the second, without duplicates).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the first collection

  **Storage `bs:in collection`**: {nbt}`list` the second collection

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the difference of the two collections
```

*Example: difference of [1, 2, 3] and [2, 3, 4]*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [2, 3, 4]
function #bs.collection:difference
# bs:out collection.value = [1]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Intersect

```{function} #bs.collection:intersect

Compute the intersection of two collections (elements present in both collections, without duplicates).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the first collection

  **Storage `bs:in collection`**: {nbt}`list` the second collection

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the intersection of the two collections
```

*Example: intersect [1, 2, 3] and [2, 3, 4]*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [2, 3, 4]
function #bs.collection:intersect
# bs:out collection.value = [2, 3]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Symmetric Difference

```{function} #bs.collection:symmetric_difference

Compute the symmetric difference of two collections (elements present in either collection, but not in both, without duplicates).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the first collection

  **Storage `bs:in collection`**: {nbt}`list` the second collection

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the symmetric difference of the two collections
```

*Example: symmetric difference of [1, 2, 3] and [2, 3, 4]*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [2, 3, 4]
function #bs.collection:symmetric_difference
# bs:out collection.value = [1, 4]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Union

```{function} #bs.collection:union

Compute the union of two collections (elements present in either collection, without duplicates).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the first collection

  **Storage `bs:in collection`**: {nbt}`list` the second collection

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the union of the two collections
```

*Example: union of [1, 2] and [2, 3]*

```mcfunction
data modify storage bs:out collection.value set value [1, 2]
data modify storage bs:in collection set value [2, 3]
function #bs.collection:union
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
:::::

---

### Slicing

Operations that split a collection into sub-collections or windows.

:::::{tab-set}
::::{tab-item} Chunk

```{function} #bs.collection:chunk {size:<value>}

Split a collection into chunks of size N. If the collection size is not divisible by N, the last chunk will contain the remaining elements.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to split

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **size**: the size of each chunk
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the list of chunks (list of lists)
```

*Example: chunk a list into pairs*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:chunk {size: 2}
# bs:out collection.value = [[1, 2], [3, 4], [5]]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Slice

```{function} #bs.collection:slice {min:<value>,max:<value>}

Extract a portion of a collection from `min` (inclusive) to `max` (exclusive). Supports negative indices (counted from the end).
The function fails if `min >= max`, or if indices are out of bounds (after negative index resolution).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to slice

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **min**: the start index (inclusive)
    - {nbt}`int` **max**: the end index (exclusive)
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the sliced collection
```

*Example: get elements from index 1 to 3*

```mcfunction
data modify storage bs:out collection.value set value [0, 1, 2, 3, 4]
function #bs.collection:slice {min: 1, max: 3}
# bs:out collection.value = [1, 2]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Sliding

```{function} #bs.collection:sliding {size:<value>,step:<value>}

Create sliding windows of elements from the collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to process

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **size**: the number of elements in each window
    - {nbt}`int` **step**: the number of elements to shift the window by
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` a list of windows (list of lists)
```

*Example: sliding window of size 2 with step 1*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4]
function #bs.collection:sliding {size: 2, step: 1}
# bs:out collection.value = [[1, 2], [2, 3], [3, 4]]
```

> **Credits**: theogiraudet

::::
:::::

---

### Take

Operations that keep elements from the start of a collection.

:::::{tab-set}
::::{tab-item} Take

```{function} #bs.collection:take {number:<value>}

Take the first N elements from a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to take from

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`int` **number**: the number of elements to take
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection containing only the first N elements
```

*Example: take first 3 elements*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:take {number: 3}
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
::::{tab-item} Take While

```{function} #bs.collection:take_while {run:<value>}

Take elements from the beginning of a collection as long as a predicate is true.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to take from

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: predicate function
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the elements taken

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`any` **value**: the current element being processed
    - {nbt}`int` **index**: the zero-based index of the current element
  :::

  **Return**: success (1) to continue taking, fail (0) otherwise
```

*Example: take elements until value is 4*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:take_while {run: "execute unless data storage bs:lambda {collection: {value: 4}}"}
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
:::::

---

### Tap

Run a lambda on the whole collection, passing it through unchanged.

:::::{tab-set}
::::{tab-item} Tap

```{function} #bs.collection:tap {run:<value>}

Execute an operation on the entire collection. Useful for side effects or logging the collection state.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the collection to process

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: lambda function to execute
  :::

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the original collection, unchanged

:Lambdas:
  **Storage `bs:lambda collection`**:
  :::{treeview}
  - {nbt}`compound` lambda data
    - {nbt}`list` **value**: the entire collection
  :::
```

*Example: log the size of the collection*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:tap {run: "tellraw @a [{\"text\":\"Collection: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# bs:out collection.value = [1, 2, 3]
```

> **Credits**: theogiraudet

::::
:::::

---

### Zip

Combine two collections element-wise.

:::::{tab-set}
::::{tab-item} Zip

```{function} #bs.collection:zip

Combine two collections into a list of pairs.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` the first collection

  **Storage `bs:in collection`**: {nbt}`list` the second collection

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` a list of pairs `[[a1, b1], [a2, b2], ...]`, truncated to the length of the shorter collection
```

*Example: zip two lists*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
data modify storage bs:in collection set value [4, 5]
function #bs.collection:zip
# bs:out collection.value = [[1, 4], [2, 5]]
```

> **Credits**: theogiraudet

::::
:::::

---

```{include} ../_templates/comments.md
```
