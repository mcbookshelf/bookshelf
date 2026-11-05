# 👀 View

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions
- ⚠️ `#bs.view:can_see_ata` is renamed to `#bs.view:can_see`, and `#bs.view:in_view_ata` to `#bs.view:in_view`
- ⚠️ `with` takes the options of each function instead of any `#bs.raycast:run` setting: `blocks` and `entities` are hitbox providers, `selector` filters the entities, and `max_distance` is 16 by default. `ignored_blocks`, `ignored_entities` and `hitbox_shape` are removed: use a provider or a `selector` instead
- ⚠️ The aimed functions aim at the outline of the blocks and at the entities a player can target by default, and `#bs.view:at_block_placement` places against the blocks as the game does, with `#bs.hitbox:get_block/interaction`
- ⚠️ The `#bs.view:can_see_through` block tag is removed: `#bs.view:can_see` uses the collision of the blocks by default, as the line of sight of mobs, so glass and leaves hide a position while flowers and torches do not. Pass another `blocks` provider to change it
- ⚠️ `#bs.view:as_aimed_entity` runs its command at the aimed entity instead of the entity that aims
- ✨ The aimed functions and `#bs.view:at_block_placement` return whether the entity aims at something

## `v3.2.0`

- 🐛 `#bs.view:at_block_placement` matches the game for special blocks such as cauldrons, hoppers, composters and scaffolding ([#498](https://github.com/mcbookshelf/bookshelf/issues/498))

## `v3.0.1`

- 🐛 `#bs.view:at_block_placement` no longer uses the hit face of the previous call ([#424](https://github.com/mcbookshelf/bookshelf/issues/424))

## `v3.0.0`

- ✨ Added the `hitbox_shape` argument to the functions that cast a ray, to choose between the `collision` and `interaction` shapes ([#318](https://github.com/mcbookshelf/bookshelf/issues/318))
- 📝 Documented the `can_see_through` block tag ([#299](https://github.com/mcbookshelf/bookshelf/pull/299))
- 🐛 Fixed the max distance of `#bs.view:can_see_ata` ([#319](https://github.com/mcbookshelf/bookshelf/issues/319))

## `v2.0.0`

- ⚡ Precise collisions, with the new hitbox module

## `v1.0.0`

- 🎉 Added the module
