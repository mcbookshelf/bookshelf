# 🗂️ Collection

**`#bs.collection:help`**

Functional programming operations for working with collections in Minecraft.

```{image} /_imgs/modules/collection.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"Simplicity is the ultimate sophistication."

-- Leonardo da Vinci
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Transformation Operations

:::::{tab-set}
::::{tab-item} Map

```{function} #bs.collection:map

Transform each element of a collection using a lambda function.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to transform.

  **Macro `run`**: {nbt}`string` Lambda function to execute on each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index).

:Outputs:
  **Storage `bs:out collection`**: {nbt}`list` The transformed collection.
```

*Example: Double each number in a list:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:map {run: "return run data get storage bs:lambda collection.value 2"}
# bs:out collection = [2, 4, 6, 8, 10]
```

::::
::::{tab-item} Flatmap

```{function} #bs.collection:flatmap

Transform each element into a collection and flatten the results into a single collection.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to transform.

  **Macro `run`**: {nbt}`string` Lambda function to execute on each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index).

:Outputs:
  **Storage `bs:out collection`**: {nbt}`list` The flattened transformed collection.
```

*Example: Transform each number into a list of its multiples and flatten:*

```mcfunction
# This would require a custom function that returns a list
data modify storage bs:out collection set value [1, 2, 3]
function #bs.collection:flatmap {run: "function mypack:get_multiples"}
# If get_multiples returns [n, n*2] for each n, result would be [1, 2, 2, 4, 3, 6]
```

::::
:::::

---

### Filtering Operations

:::::{tab-set}
::::{tab-item} Filter

```{function} #bs.collection:filter

Keep only elements that satisfy a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to filter.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to keep the element.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`list` The filtered collection containing only matching elements.
```

*Example: Keep only even numbers:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5, 6]
function #bs.collection:filter {run: "execute store success score #r bs.ctx run data get storage bs:lambda collection.value"}
# Further filtering logic needed for even check
```

::::
::::{tab-item} Find

```{function} #bs.collection:find

Find the first element that satisfies a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to search.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`any` The first matching element, or nothing if no match found.

  **Return**: Success (1) if element found, fail (0) otherwise.
```

*Example: Find first number greater than 3:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store success score #found bs.ctx run function #bs.collection:find {run: "execute if data storage bs:lambda collection{value: 4}"}
# bs:out collection = 4, #found = 1
```

::::
:::::

---

### Validation Operations

:::::{tab-set}
::::{tab-item} Any

```{function} #bs.collection:any

Test if at least one element satisfies a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to test.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Return**: Success (1) if any element matches, fail (0) if none match or collection is empty.
```

*Example: Check if any number equals 3:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store success score #result bs.ctx run function #bs.collection:any {run: "execute if data storage bs:lambda collection{value: 3}"}
# #result = 1 (true)
```

::::
::::{tab-item} All

```{function} #bs.collection:all

Test if all elements satisfy a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to test.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Return**: Success (1) if all elements match or collection is empty (vacuous truth), fail (0) if any element doesn't match.
```

*Example: Check if all numbers are positive:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store success score #result bs.ctx run function #bs.collection:all {run: "execute if data storage bs:lambda collection.value > 0"}
# #result = 1 (true)
```

```{admonition} Empty Collection Behavior
:class: note

For an empty collection, `all` returns success (1) following the principle of vacuous truth - all zero elements satisfy the condition.
```

::::
::::{tab-item} None

```{function} #bs.collection:none

Test if no elements satisfy a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to test.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Return**: Success (1) if no elements match or collection is empty, fail (0) if any element matches.
```

*Example: Check if no numbers equal 10:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store success score #result bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{value: 10}"}
# #result = 1 (true)
```

::::
:::::

---

### Aggregation Operations

:::::{tab-set}
::::{tab-item} Count

```{function} #bs.collection:count

Count the number of elements in a collection.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to count.

:Outputs:
  **Return**: Integer count of elements in the collection.
```

*Example: Count elements in a list:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
execute store result score #count bs.ctx run function #bs.collection:count
# #count = 5
```

::::
::::{tab-item} Min

```{function} #bs.collection:min

Find the minimum value in a collection of numbers.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection of numbers.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`int` The minimum value.
```

*Example: Find minimum value:*

```mcfunction
data modify storage bs:out collection set value [5, 2, 8, 1, 9]
function #bs.collection:min
# bs:out collection = 1
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the behavior is undefined. Ensure the collection has at least one element.
```

::::
::::{tab-item} Max

```{function} #bs.collection:max

Find the maximum value in a collection of numbers.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection of numbers.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`int` The maximum value.
```

*Example: Find maximum value:*

```mcfunction
data modify storage bs:out collection set value [5, 2, 8, 1, 9]
function #bs.collection:max
# bs:out collection = 9
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the behavior is undefined. Ensure the collection has at least one element.
```

::::
::::{tab-item} Average

```{function} #bs.collection:average

Calculate the average (mean) of a collection of numbers. Uses an internal scale of 1000 for precision.

:Inputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection of numbers.

:Outputs:
  **Return**: Integer average at scale 1000.

  **Storage `bs:out collection`**: {nbt}`double` The average value.
```

*Example: Calculate average of integers:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:average
# bs:out collection = 3.0d (15/5)
```

*Example: Calculate average of decimals:*

```mcfunction
data modify storage bs:out collection set value [1.5d, 2.5d, 3.0d]
function #bs.collection:average
# bs:out collection = 2.333d ((1.5 + 2.5 + 3.0) / 3)
```

```{admonition} Precision
:class: note

The function uses an internal scale of 1000 (10³) to handle decimal values with up to 3 decimal places of precision.
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, division by zero will occur. Ensure the collection has at least one element.
```

::::
::::{tab-item} Sum

```{function} #bs.collection:sum

Calculate the sum of all numbers in a collection. Uses an internal scale of 1000 for precision.

:Inputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection of numbers.

:Outputs:
  **Return**: Integer sum at scale 1000.

  **Storage `bs:out collection`**: {nbt}`double` The sum as a double value.
```

*Example: Sum integers:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:sum
# bs:out collection = 15.0d
```

*Example: Sum decimals:*

```mcfunction
data modify storage bs:out collection set value [1.5d, 2.5d, 3.0d]
function #bs.collection:sum
# bs:out collection = 7.0d (sum of 1.5 + 2.5 + 3.0)
```

```{admonition} Precision
:class: note

The function uses an internal scale of 1000 (10³) to handle decimal values with up to 3 decimal places of precision.
```

```{admonition} Empty Collection Behavior
:class: tip

For an empty collection, the sum is 0.
```

::::
::::{tab-item} Reduce

```{function} #bs.collection:reduce

Reduce a collection to a single value by applying a function that combines the accumulator with each element.

:Inputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection to reduce.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

:Outputs:
  **Storage `bs:out collection`**: The final accumulated value.

  **Return**: 0 on success, fail if the collection is empty.
```

*Example: Sum all numbers using reduce:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:reduce {run: "bs.collection:sum_tmp"}
# bs:out collection = 15
```

*Example: Calculate product using reduce:*

```mcfunction
data modify storage bs:out collection set value [2, 3, 4]
function #bs.collection:reduce {run: "function bs.collection:internal/reduce_product"}
# bs:out collection = 24
```

```{admonition} Lambda Function Requirements
:class: note

The lambda function receives:
- **`bs:lambda collection.accumulator`**: The current accumulated value
- **`bs:lambda collection.value`**: The current element being processed
- **`bs:lambda collection.index`**: The zero-based index of the current element

The lambda must set **`bs:lambda collection.result`** to the new accumulator value.
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the function returns fail. Ensure the collection has at least one element.
```

```{admonition} Initial Value
:class: tip

The reduce operation uses the first element of the collection as the initial accumulator value, then processes the remaining elements.
```

::::
::::{tab-item} Fold

```{function} #bs.collection:fold

Reduce a collection to a single value by applying a function that combines the accumulator with each element, starting with a provided initial value.

:Inputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection to fold.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

  **Macro `initial`**: {nbt}`any` Initial value for the accumulator.

:Outputs:
  **Storage `bs:out collection`**: The final accumulated value.

  **Return**: 0 on success.
```

*Example: Sum with initial value:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:fold {run: "bs.collection:sum_tmp", initial: 10}
# bs:out collection = 25 (10 + 1 + 2 + 3 + 4 + 5)
```

*Example: Build a list with fold:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3]
function #bs.collection:fold {run: "function bs.collection:internal/fold_append", initial: []}
# bs:out collection = [1, 2, 3]
```

```{admonition} Lambda Function Requirements
:class: note

The lambda function receives:
- **`bs:lambda collection.accumulator`**: The current accumulated value
- **`bs:lambda collection.value`**: The current element being processed
- **`bs:lambda collection.index`**: The zero-based index of the current element

The lambda must set **`bs:lambda collection.result`** to the new accumulator value.
```

```{admonition} Empty Collection Behavior
:class: tip

For an empty collection, fold returns the initial value. This makes fold more flexible than reduce for handling empty collections.
```

```{admonition} Difference from Reduce
:class: note

**Fold** accepts an initial value and processes all elements, while **reduce** uses the first element as the initial value and processes the remaining elements. Use fold when you need to:
- Handle empty collections gracefully
- Start with a specific initial value
- Build a result of a different type than the collection elements
```

::::
:::::

---

### Iteration Operations

```{function} #bs.collection:foreach

Execute an operation on each element of a collection.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to iterate over.

  **Macro `run`**: {nbt}`string` Lambda function to execute on each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index).

:Outputs:
  None. This function is used for side effects only.
```

*Example: Display each element:*

```mcfunction
data modify storage bs:out collection set value ["Hello", "World", "!"]
function #bs.collection:foreach {run: "tellraw @a [{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# Displays each string to all players
```

---

### Utility Operations

```{function} #bs.collection:flatten

Flatten a nested collection by one level.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The nested collection to flatten.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`list` The flattened collection.
```

*Example: Flatten a 2D array:*

```mcfunction
data modify storage bs:out collection set value [[1, 2], [3, 4], [5]]
function #bs.collection:flatten
# bs:out collection = [1, 2, 3, 4, 5]
```

---

```{function} #bs.collection:reverse

Reverse the order of elements in a collection.

:Inputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection to reverse.

:Outputs:
  **Storage `bs:out collection`**: {nbt}`list` The collection with elements in reversed order.
```

*Example: Reverse a list:*

```mcfunction
data modify storage bs:out collection set value [1, 2, 3, 4, 5]
function #bs.collection:reverse
# bs:out collection = [5, 4, 3, 2, 1]
```

*Example: Reverse a list of strings:*

```mcfunction
data modify storage bs:out collection set value ["a", "b", "c"]
function #bs.collection:reverse
# bs:out collection = ["c", "b", "a"]
```

```{admonition} Empty Collection Behavior
:class: tip

For an empty collection, the function returns an empty collection. This operation is safe for all collection sizes.
```

---

## 💡 Understanding Lambda Functions

All collection operations use **lambda functions** passed via the `run` macro parameter. These functions have access to:

- **`bs:lambda collection.value`**: The current element being processed
- **`bs:lambda collection.index`**: The zero-based index of the current element

### Lambda Return Values

- **Transformation operations** (`map`, `flatmap`): Should return a value that will be added to the result
- **Predicate operations** (`filter`, `find`, `any`, `all`, `none`): Should return success (1) or fail (0)
- **Iteration operations** (`foreach`): Return value is ignored

### Examples

```mcfunction
# Map: Double each number
function #bs.collection:map {run: "return run data get storage bs:lambda collection.value 2"}

# Filter: Keep only elements at even indices
function #bs.collection:filter {run: "execute store result score #r bs.ctx run data get storage bs:lambda collection.index"}
# Additional modulo check needed

# Any: Check if value 5 exists
function #bs.collection:any {run: "execute if data storage bs:lambda collection{value: 5}"}

# ForEach: Log each element
function #bs.collection:foreach {run: "tellraw @a [{\"score\":{\"name\":\"#i\",\"objective\":\"bs.ctx\"}},{\"text\":\": \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
```

---

## ⚡ Performance Considerations

- All operations use **recursive processing** and process elements sequentially
- **Short-circuit evaluation**: `any`, `all`, `none`, and `find` stop processing as soon as the result is determined
- **Empty collections**: Return immediately with appropriate default values
- **Lambda overhead**: Each element invokes the lambda function, so complex lambdas impact performance

---

## 📝 Credits

> **Module Design**: Bookshelf Team
