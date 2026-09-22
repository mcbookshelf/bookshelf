# ❤️ Health

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions ([#597](https://github.com/mcbookshelf/bookshelf/pull/597))
- ⚠️ `#bs.health:get_health` and `#bs.health:get_max_health` no longer take a `scale` and return the value: they write it to storage instead ([#597](https://github.com/mcbookshelf/bookshelf/pull/597))
- ⚠️ `#bs.health:time_to_live` is split into `#bs.health:set_ttl` and `#bs.health:set_ttl_on_death`, each with one required argument ([#597](https://github.com/mcbookshelf/bookshelf/pull/597))
- ⚠️ The lifetime is a [minecraft:time](https://minecraft.wiki/w/Argument_types#time) such as `10s`, or ticks: the `unit` argument is gone ([#597](https://github.com/mcbookshelf/bookshelf/pull/597))

## `v4.2.0`

- ⚡ Optimized health computation using new number providers ([#577](https://github.com/mcbookshelf/bookshelf/pull/577))

## `v3.1.0`

- 🐛 Fixed healing on Paper servers always setting players' health to maximum ([#466](https://github.com/mcbookshelf/bookshelf/issues/466))

## `v3.0.2`

- 🐛 Fixed health updates when using percentage-based max health attributes ([#428](https://github.com/mcbookshelf/bookshelf/pull/428))

## `v3.0.1`

- 🐛 Ensured player health updates consistently ([#410](https://github.com/mcbookshelf/bookshelf/issues/410))
- 🐛 Players are now killed when their health drops below 0, unless in Creative or Spectator mode ([#426](https://github.com/mcbookshelf/bookshelf/pull/426))

## `v3.0.0`

- ⚠️ `#bs.health:get_max_health` now returns the base value only, modifiers excluded ([#396](https://github.com/mcbookshelf/bookshelf/issues/396))

## `v2.2.0`

- 🐛 Fixed the unload function ([#243](https://github.com/mcbookshelf/bookshelf/issues/243))

## `v2.0.0`

- ✨ Added player health manipulation

## `v1.0.0`

- ⚙️ Load error `TooLazyException`: our devs are too busy coding the future to dig up the past...
