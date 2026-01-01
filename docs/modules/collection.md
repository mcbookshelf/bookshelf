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
  **Storage `bs:out collection.value`**: {nbt}`list` The transformed collection.
```

*Example: Double each number in a list:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:map {run: "return run data get storage bs:lambda collection.value 2"}
# bs:out collection.value = [2, 4, 6, 8, 10]
```

::::
::::{tab-item} Flatmap

```{function} #bs.collection:flatmap

Transform each element into a collection and flatten the results into a single collection.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to transform.

  **Macro `run`**: {nbt}`string` Lambda function to execute on each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index).

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The flattened transformed collection.
```

*Example: Transform each number into a list of its multiples and flatten:*

```mcfunction
# This would require a custom function that returns a list
data modify storage bs:out collection.value set value [1, 2, 3]
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
  **Storage `bs:out collection.value`**: {nbt}`list` The filtered collection containing only matching elements.
```

*Example: Keep only even numbers:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5, 6]
function #bs.collection:filter {run: "execute store success score #r bs.ctx run data get storage bs:lambda collection.value"}
# Further filtering logic needed for even check
```

::::
::::{tab-item} Partition

```{function} #bs.collection:partition

Split a collection into two collections based on a predicate: one containing elements that match the predicate, and one containing elements that don't.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to partition.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) for match, fail (0) otherwise.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` A list containing two lists: `[matches, non_matches]`.
```

*Example: Partition even and odd numbers:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
# Assume is_even returns 1 for even numbers, 0 for odd
function #bs.collection:partition {run: "function mypack:is_even"}
# bs:out collection.value = [[2, 4], [1, 3, 5]]
```

::::
::::{tab-item} Find

```{function} #bs.collection:find

Find the first element that satisfies a predicate condition.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to search.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`any` The first matching element, or nothing if no match found.

  **Storage `bs:out collection.index`**: {nbt}`int` The zero-based index of the matching element, or -1 if no match found.

  **Return**: Success (1) if element found, fail (0) otherwise.
```

*Example: Find first number equal to 4:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #found bs.ctx run function #bs.collection:find {run: "execute if data storage bs:lambda collection{value: 4}"}
# bs:out collection.value = 4
# bs:out collection.index = 3
# #found = 1
```

::::
::::{tab-item} Find Last

```{function} #bs.collection:find_last

Find the last element that satisfies a predicate condition.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to search.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) to match.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`any` The last matching element, or nothing if no match found.

  **Storage `bs:out collection.index`**: {nbt}`int` The zero-based index of the last matching element, or -1 if no match found.

  **Return**: Success (1) if element found, fail (0) otherwise.
```

*Example: Find last occurrence of 3:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
execute store success score #found bs.ctx run function #bs.collection:find_last {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 3
# bs:out collection.index = 4 (last 3 is at index 4)
# #found = 1
```

```{admonition} Search Direction
:class: note

Unlike `find` which searches from the beginning, `find_last` searches from the end of the collection backwards, returning the last element that matches the predicate.
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
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
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
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
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
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store success score #result bs.ctx run function #bs.collection:none {run: "execute if data storage bs:lambda collection{value: 10}"}
# #result = 1 (true)
```

::::
::::{tab-item} Is Empty

```{function} #bs.collection:is_empty

Test if a collection is empty (contains no elements).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to test.

:Outputs:
  **Return**: Success (1) if the collection is empty, fail (0) if it contains at least one element.
```

*Example: Check if a collection is empty:*

```mcfunction
data modify storage bs:out collection.value set value []
execute store success score #result bs.ctx run function #bs.collection:is_empty
# #result = 1 (true - collection is empty)
```

*Example: Check if a collection has elements:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
execute store success score #result bs.ctx run function #bs.collection:is_empty
# #result = 0 (false - collection is not empty)
```

```{admonition} Simple Size Check
:class: tip

This function is a lightweight alternative to `count` when you only need to know if a collection has any elements, without counting them. It's more efficient than checking `count > 0`.
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
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
execute store result score #count bs.ctx run function #bs.collection:count
# #count = 5
```

::::
::::{tab-item} Min

```{function} #bs.collection:imin

Find the minimum value in a collection of integers.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection of integers.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` The minimum value.
```

*Example: Find minimum value:*

```mcfunction
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
function #bs.collection:imin
# bs:out collection.value = 1
```

```{admonition} Integer Only
:class: warning

This function only supports integers. Decimal values will be treated as integers (truncated) or may cause unexpected behavior. No scaling is applied.
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the behavior is undefined. Ensure the collection has at least one element.
```

::::
::::{tab-item} Max

```{function} #bs.collection:imax

Find the maximum value in a collection of integers.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection of integers.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` The maximum value.
```

*Example: Find maximum value:*

```mcfunction
data modify storage bs:out collection.value set value [5, 2, 8, 1, 9]
function #bs.collection:imax
# bs:out collection.value = 9
```

```{admonition} Integer Only
:class: warning

This function only supports integers. Decimal values will be treated as integers (truncated) or may cause unexpected behavior. No scaling is applied.
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the behavior is undefined. Ensure the collection has at least one element.
```

::::
::::{tab-item} Average

```{function} #bs.collection:average

Calculate the average (mean) of a collection of numbers.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection of numbers.

  **Macro `scale`**: {nbt}`int` The scale factor for the returned integer value.

:Outputs:
  **Return**: Integer average scaled by the provided scale factor.

  **Storage `bs:out collection.value`**: {nbt}`double` The exact average value as a double.
```

*Example: Calculate average of integers:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:average {scale: 1}
# bs:out collection.value = 3.0d (15/5)
# return = 3
```

*Example: Calculate average with scaling:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2]
function #bs.collection:average {scale: 100}
# bs:out collection.value = 1.5d
# return = 150 (1.5 * 100)
```

```{admonition} Integer Only
:class: warning

This function is designed for collections of integers. Using it with decimal values may yield unexpected results for the exact average stored in `bs:out collection.value`, although the scaled return value might still be computed.
```

```{admonition} Storage Value
:class: note

The value stored in `bs:out collection.value` is always the exact calculated average as a double, regardless of the scale parameter. The scale parameter only affects the integer return value of the function.
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
  **Storage `bs:out collection.value`**: {nbt}`list` The collection of numbers.

:Outputs:
  **Return**: Integer sum at scale 1000.

  **Storage `bs:out collection.value`**: {nbt}`double` The sum as a double value.
```

*Example: Sum integers:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:sum
# bs:out collection.value = 15.0d
```

*Example: Sum decimals:*

```mcfunction
data modify storage bs:out collection.value set value [1.5d, 2.5d, 3.0d]
function #bs.collection:sum
# bs:out collection.value = 7.0d (sum of 1.5 + 2.5 + 3.0)
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
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to reduce.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

:Outputs:
  **Storage `bs:out collection.value`**: The final accumulated value.

  **Return**: 0 on success, fail if the collection is empty.
```

*Example: Sum all numbers using reduce:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reduce {run: "bs.collection:sum_tmp"}
# bs:out collection.value = 15
```

*Example: Calculate product using reduce:*

```mcfunction
data modify storage bs:out collection.value set value [2, 3, 4]
function #bs.collection:reduce {run: "function bs.collection:internal/reduce_product"}
# bs:out collection.value = 24
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
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to fold.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

  **Macro `initial`**: {nbt}`any` Initial value for the accumulator. Must be a valid SNBT value (e.g., strings must be quoted: `'foo'`).

:Outputs:
  **Storage `bs:out collection.value`**: The final accumulated value.

  **Return**: 0 on success.
```

*Example: Sum with initial value:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:fold {run: "bs.collection:sum_tmp", initial: 10}
# bs:out collection.value = 25 (10 + 1 + 2 + 3 + 4 + 5)
```

*Example: Build a list with fold:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:fold {run: "function bs.collection:internal/fold_append", initial: []}
# bs:out collection.value = [1, 2, 3]
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
::::{tab-item} Reduce Right

```{function} #bs.collection:reduce_right

Reduce a collection to a single value by applying a function from right to left, starting with the last element as the initial accumulator.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to reduce.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

:Outputs:
  **Storage `bs:out collection.value`**: The final accumulated value.

  **Return**: 0 on success, fail if the collection is empty.
```

*Example: Build a reversed list using reduce_right:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reduce_right {run: "bs.collection:sum_tmp"}
# Processes: 5, 4, 3, 2, 1 (right to left)
```

```{admonition} Processing Direction
:class: note

**Reduce Right** processes elements from right to left (last to first), using the last element as the initial accumulator. This is useful for operations where order matters, such as building lists in reverse or right-associative operations.
```

```{admonition} Empty Collection Behavior
:class: warning

For an empty collection, the function returns fail. Ensure the collection has at least one element.
```

::::
::::{tab-item} Fold Right

```{function} #bs.collection:fold_right

Reduce a collection to a single value by applying a function from right to left with a provided initial value.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to fold.

  **Macro `run`**: {nbt}`string` Lambda function that combines accumulator and value.

  **Macro `initial`**: {nbt}`any` Initial value for the accumulator. Must be a valid SNBT value (e.g., strings must be quoted: `'foo'`).

:Outputs:
  **Storage `bs:out collection.value`**: The final accumulated value.

  **Return**: 0 on success.
```

*Example: Build a reversed list with fold_right:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:fold_right {run: "function bs.collection:internal/fold_append", initial: []}
# Processes: 3, 2, 1 (right to left)
```

```{admonition} Processing Direction
:class: note

**Fold Right** processes elements from right to left (last to first) with an initial value. This is the right-to-left equivalent of `fold`, useful for right-associative operations.
```

```{admonition} Lambda Function Requirements
:class: note

The lambda function receives:
- **`bs:lambda collection.accumulator`**: The current accumulated value
- **`bs:lambda collection.value`**: The current element being processed

The lambda must set **`bs:lambda collection.result`** to the new accumulator value.
```

```{admonition} Difference from Fold
:class: tip

**Fold Right** processes from right to left, while **Fold** processes from left to right. Use fold_right when the order of processing matters for the operation, such as building reversed structures or implementing right-associative operators.
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
data modify storage bs:out collection.value set value ["Hello", "World", "!"]
function #bs.collection:foreach {run: "tellraw @a [{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# Displays each string to all players
```

---

```{function} #bs.collection:peek

Execute an operation on each element of a collection and return the original collection. Useful for debugging or side effects in a chain of operations.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to iterate over.

  **Macro `run`**: {nbt}`string` Lambda function to execute on each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index).

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The original collection, unchanged.
```

*Example: Log elements while processing:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
# Log each element then continue with other operations
function #bs.collection:peek {run: "tellraw @a [{\"text\":\"Processing: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# bs:out collection.value = [1, 2, 3]
```

---

```{function} #bs.collection:tap

Execute an operation on the entire collection. Useful for side effects or logging the collection state.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The collection to process.

  **Macro `run`**: {nbt}`string` Lambda function to execute. Receives `bs:lambda collection.value` which is the entire collection.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The original collection, unchanged.
```

*Example: Log the size of the collection:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:tap {run: "tellraw @a [{\"text\":\"Collection: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
# bs:out collection.value = [1, 2, 3]
```

---

### Intermediate Operations (transform the stream, return new collection)

:::::{tab-set}
::::{tab-item} Reverse

```{function} #bs.collection:reverse

Reverse the order of elements in a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to reverse.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection with elements in reversed order.
```

*Example: Reverse a list:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:reverse
# bs:out collection.value = [5, 4, 3, 2, 1]
```

```{admonition} Empty Collection Behavior
:class: tip

For an empty collection, the function returns an empty collection. This operation is safe for all collection sizes.
```

::::
::::{tab-item} Take

```{function} #bs.collection:take

Take the first N elements from a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to take from.

  **Macro `number`**: {nbt}`int` The number of elements to take.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection containing only the first N elements.
```

*Example: Take first 3 elements:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:take {number: 3}
# bs:out collection.value = [1, 2, 3]
```

*Example: Take more elements than available:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2]
function #bs.collection:take {number: 5}
# bs:out collection.value = [1, 2]
```

```{admonition} Empty Collection
:class: tip

If the collection is empty or the requested number is 0, the result is an empty collection.
```

::::
::::{tab-item} Drop

```{function} #bs.collection:drop

Drop the first N elements from a collection.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to drop from.

  **Macro `number`**: {nbt}`int` The number of elements to drop.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection with the first N elements removed.
```

*Example: Drop first 2 elements:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:drop {number: 2}
# bs:out collection.value = [3, 4, 5]
```

*Example: Drop more elements than available:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2]
function #bs.collection:drop {number: 5}
# bs:out collection.value = []
```

```{admonition} Empty Collection
:class: tip

If the collection is empty or the requested number is greater than the collection size, the result is an empty collection.
```

::::
:::::

---

### Utility Operations

```{function} #bs.collection:flatten

Flatten a nested collection by one level.

:Inputs:
  **Storage `bs:in collection`**: {nbt}`list` The nested collection to flatten.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The flattened collection.
```

*Example: Flatten a 2D array:*

```mcfunction
data modify storage bs:out collection.value set value [[1, 2], [3, 4], [5]]
function #bs.collection:flatten
# bs:out collection.value = [1, 2, 3, 4, 5]
```

---

```{function} #bs.collection:chunk

Split a collection into chunks of size N. If the collection size is not divisible by N, the last chunk will contain the remaining elements.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to split.

  **Macro `size`**: {nbt}`int` The size of each chunk.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The list of chunks (list of lists).
```

*Example: Chunk a list into pairs:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 5]
function #bs.collection:chunk {size: 2}
# bs:out collection.value = [[1, 2], [3, 4], [5]]
```

---

```{function} #bs.collection:sliding

Create sliding windows of elements from the collection. Partial windows are kept only if they are not subsets of the previous window (rule: `step > remaining_space`).

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to process.

  **Macro `size`**: {nbt}`int` The number of elements in each window.

  **Macro `step`**: {nbt}`int` The number of elements to shift the window by.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`list` A list of windows (list of lists).
```

*Example: Sliding window of size 2 with step 1:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4]
function #bs.collection:sliding {size: 2, step: 1}
# bs:out collection.value = [[1, 2], [2, 3], [3, 4]]
```

---

```{function} #bs.collection:index_of

Find the index of the first element matching a predicate.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to search.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) for a match.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` The zero-based index of the first matching element, or -1 if no match found.
```

*Example: Find the index of the first occurrence of value 3:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
function #bs.collection:index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 2 (first 3 is at index 2)
```

*Example: Find the index of a string:*

```mcfunction
data modify storage bs:out collection.value set value ["a", "b", "c", "b", "d"]
function #bs.collection:index_of {run: "execute if data storage bs:lambda collection{value: 'b'}"}
# bs:out collection.value = 1 (first "b" is at index 1)
```

```{admonition} Not Found Behavior
:class: tip

When no element matches the predicate, the function returns -1. Check the returned value to determine if a match was found (index >= 0) or not (index = -1).
```

---

```{function} #bs.collection:last_index_of

Find the index of the last element matching a predicate, searching from right to left.

:Inputs:
  **Storage `bs:out collection.value`**: {nbt}`list` The collection to search.

  **Macro `run`**: {nbt}`string` Predicate function to test each element. Receives `bs:lambda collection.value` (element value) and `bs:lambda collection.index` (element index). Must return success (1) for a match.

:Outputs:
  **Storage `bs:out collection.value`**: {nbt}`int` The zero-based index of the last matching element, or -1 if no match found.
```

*Example: Find the index of the last occurrence of value 3:*

```mcfunction
data modify storage bs:out collection.value set value [1, 2, 3, 4, 3, 5]
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 3}"}
# bs:out collection.value = 4 (last 3 is at index 4)
```

*Example: Find the index of the last string match:*

```mcfunction
data modify storage bs:out collection.value set value ["a", "b", "c", "b", "d"]
function #bs.collection:last_index_of {run: "execute if data storage bs:lambda collection{value: 'b'}"}
# bs:out collection.value = 3 (last "b" is at index 3)
```

```{admonition} Search Direction
:class: note

Unlike `index_of` which searches from left to right, `last_index_of` searches from right to left to efficiently find the last occurrence. However, the returned index is still zero-based from the beginning of the collection.
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
