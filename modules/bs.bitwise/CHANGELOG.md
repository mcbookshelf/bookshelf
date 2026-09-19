# 🖥️ Bitwise

## Unreleased

- ⚠️ Every feature is now a number provider ([#589](https://github.com/mcbookshelf/bookshelf/pull/589))
- ⚠️ Removed `#bs.bitwise:two_complement`: negate the number, or `and` it with `2147483647` to drop the sign bit ([#589](https://github.com/mcbookshelf/bookshelf/pull/589))
- ⚠️ `bit_count` and `bit_length` now read a negative number as its 32 stored bits, as `and` and `not` do: both give 32 for `-1` ([#589](https://github.com/mcbookshelf/bookshelf/pull/589))
- ✨ Added `bs.bitwise:shift_left` and `bs.bitwise:shift_right` ([#589](https://github.com/mcbookshelf/bookshelf/pull/589))

## `v2.0.0`

- ⚠️ Bitwise operations moved out of the math module into this one
- ⚠️ Inputs and outputs were reworked to follow new conventions
- ⚠️ Removed `msb`, the most significant bit is `bit_length` minus one ([#165](https://github.com/mcbookshelf/bookshelf/pull/165))
- ✨ Added `#bs.bitwise:bit_count` to count the bits set in a number ([#158](https://github.com/mcbookshelf/bookshelf/pull/158))

## `v1.0.0`

- ⚙️ Load error `TooLazyException`: our devs are too busy coding the future to dig up the past...
