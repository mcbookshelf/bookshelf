# 🔦 Raycast

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions
- ⚠️ `#bs.raycast:run` is renamed to `#bs.raycast:cast`
- ⚠️ `blocks` and `entities` take a hitbox block provider and entity provider instead of `true` or `false`: without one, the ray goes through blocks or entities. `selector` filters the entities the ray checks: by default, the ones the provider gives a box to
- ⚠️ `ignored_blocks` and `ignored_entities` are removed: use a provider that skips them, or a `selector`
- ⚠️ `piercing` is removed in favor of `#bs.raycast:pierce`, which runs the commands of the ray for every block and entity it goes through, nearest first. The ray stops at a command unless it returns a non-zero value, so a function must end with `return 1` to keep piercing
- ⚠️ `on_targeted_block`, `on_targeted_entity`, `on_entry_point` and `on_exit_point` are renamed to `on_block`, `on_entity`, `on_entry` and `on_exit`. `on_exit` is only available in `#bs.raycast:pierce`
- ⚠️ The `$raycast.*` lambda scores are replaced by the `bs.raycast:face/<face>` and `bs.raycast:flag/<flag>` predicates, the `bs.raycast:entry/<distance|x|y|z>` and `bs.raycast:exit/<distance|x|y|z>` float providers, and the `bs.raycast:block/<x|y|z>` int providers. `prev_entry_distance` and `prev_exit_distance` are removed: keep them in a command of the ray
- ✨ A ray never hits an entity tagged `bs.raycast.omit`, such as the entity that casts it
- ✨ Custom entity providers are supported: an entity whose boxes go beyond its own hitbox, or that has none, must be tagged `bs.hitbox.unbounded`

## `v4.2.1`

- 🐛 Entity IDs no longer collide between casts ([#586](https://github.com/mcbookshelf/bookshelf/issues/586))

## `v4.1.0`

- 🐛 Fixed the scaling of the `$raycast.prev_entry_distance` and `$raycast.prev_exit_distance` lambda scores ([#556](https://github.com/mcbookshelf/bookshelf/issues/556))

## `v4.0.0`

- ⚠️ Removed the deprecated `bs:out raycast` and `bs:lambda raycast` storage data ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- ⚠️ Renamed the `on_hit_point` callback to `on_entry_point`, and added an `on_exit_point` callback ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- ⚠️ Renamed `$raycast.distance` to `$raycast.entry_distance`, and added `$raycast.exit_distance` ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- ⚠️ Replaced `$raycast.pierce_distance`, a delta, with `$raycast.prev_entry_distance` and `$raycast.prev_exit_distance`, absolute values ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- ✨ Added the `$raycast.entry_point.[x,y,z]` and `$raycast.exit_point.[x,y,z]` lambda scores, for the hit position relative to the target ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- ✨ Added the `$raycast.targeted_block.[x,y,z]` lambda scores, for the coordinates of the targeted block ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))
- 📝 Added a "How to use" section to the documentation, with examples for callbacks, filtering, piercing and hitbox providers ([#531](https://github.com/mcbookshelf/bookshelf/pull/531))

## `v3.2.0`

- ✨ Added custom block hitboxes, and improved piercing through several layers ([#473](https://github.com/mcbookshelf/bookshelf/issues/473))

## `v3.1.0`

- ✨ Added support for baked and custom entity hitboxes ([#465](https://github.com/mcbookshelf/bookshelf/pull/465))
- ✨ `#bs.raycast:run` computes all lambda data before running the callbacks ([#445](https://github.com/mcbookshelf/bookshelf/issues/445))
- 🐛 Rays stop at the nearest hit when they detect both blocks and entities ([#457](https://github.com/mcbookshelf/bookshelf/issues/457))

## `v3.0.0`

- ⚡ Added more lambda values to the callbacks ([#358](https://github.com/mcbookshelf/bookshelf/issues/358))
- ⚡ Added the `hitbox_shape` argument to `#bs.raycast:run`, to choose between the `collision` and `interaction` shapes ([#318](https://github.com/mcbookshelf/bookshelf/issues/318))

## `v2.2.0`

- ✨ Added the `piercing` and callback options to `#bs.raycast:run` ([#245](https://github.com/mcbookshelf/bookshelf/issues/245))
- 🐛 Fixed collisions with paintings ([#262](https://github.com/mcbookshelf/bookshelf/pull/262))

## `v2.0.0`

- 🎉 Added the module, with precise collisions
