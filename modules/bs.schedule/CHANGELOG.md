# ⏲️ Schedule

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions
- ⚠️ `#bs.schedule:schedule` is split into `#bs.schedule:schedule/<append|replace|unique>`, which differ in what happens to the commands already scheduled with the same id
- ⚠️ `#bs.schedule:schedule` no longer returns a unique identifier: commands are cancelled with their `id`
- ⚠️ `#bs.schedule:cancel_all` and `#bs.schedule:cancel_one` are replaced by `#bs.schedule:cancel/all` and `#bs.schedule:cancel/one`, the latter cancelling every command the executing entity scheduled with the id instead of a single command
- ⚠️ The `id` is required and is a string, it no longer matches any NBT
- ⚠️ The delay is a [minecraft:time](https://minecraft.wiki/w/Argument_types#time) such as `10s`, or ticks: the `unit` argument is gone

## `v3.0.0`

- ⚠️ Changed the `#bs.schedule:schedule` signature for better consistency with other functions that take a callback ([#282](https://github.com/mcbookshelf/bookshelf/issues/282))

## `v2.2.0`

- ⚡ Optimized the module for improved performance ([#265](https://github.com/mcbookshelf/bookshelf/pull/265))
- 🐛 Fixed the execution loop being interrupted by callbacks ([#254](https://github.com/mcbookshelf/bookshelf/issues/254))
- 🐛 Fixed scheduling outside the overworld ([#264](https://github.com/mcbookshelf/bookshelf/issues/264))

## `v2.0.0`

- ⚠️ Inputs and outputs where completly reworked to follow new conventions
- ✨ Scheduled commands now keep the entity and location that triggered them

## `v1.0.0`

- ⚙️ Load error `TooLazyException`: our devs are too busy coding the future to dig up the past...
