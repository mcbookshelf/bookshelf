# 🎯 Hitbox

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ `get_block_shape`, `get_block_collision` and the `callback/get_block_*` providers are replaced by `#bs.hitbox:get_block/<collision|outline|interaction>`, each with a `_with_fluid` variant ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ `#bs.hitbox:get_entity` is replaced by `#bs.hitbox:get_entity/<sized|living|pushable|solid|targetable>`, each with a predicate of the same name ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ The `is_in_*` and `is_entity_in_*` functions are replaced by `#bs.hitbox:is_inside/<block|entity>` and `#bs.hitbox:overlaps/<block|blocks>`, which take the providers to use as inputs ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ Removed `#bs.hitbox:set_entity`, `#bs.hitbox:bake_entity` and `#bs.hitbox:reset_entity` in favor of custom entity providers ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ Replaced the block tags `can_pass_through`, `intangible`, `is_full_cube`, `is_full_cube_shape`, `is_fluid`, `is_water` and `is_waterlogged` with `has_no_collision`, `has_no_outline`, `is_full_cube_outline`, `has_fluid` and `is_liquid` ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))
- ⚠️ Removed the entity type tags `intangible`, `is_shaped` and `is_sized` in favor of the `bs.hitbox:get_entity/*` predicates ([#000](https://github.com/mcbookshelf/bookshelf/pull/000))

## `v4.1.1`

- 🐛 Fixed fluid providers ignoring the water in non-waterloggable fluid blocks such as kelp and seagrass ([#563](https://github.com/mcbookshelf/bookshelf/issues/563))
- 📝 Expanded block tag documentation and added `#bs.hitbox:is_water`, `#bs.hitbox:is_waterlogged`, `#bs.hitbox:is_full_cube_shape` and `#bs.hitbox:is_full_cube_collision` ([#569](https://github.com/mcbookshelf/bookshelf/pull/569))

## `v4.1.0`

- ✨ Updated entity hitboxes for Minecraft 26.2 ([#555](https://github.com/mcbookshelf/bookshelf/pull/555))

## `v4.0.1`

- 🐛 Fixed glow squid entities hitboxes and the `is_sized` entity type tag ([#543](https://github.com/mcbookshelf/bookshelf/issues/543))

## `v4.0.0`

- ⚠️ Removed deprecated functions and tags from previous versions ([#523](https://github.com/mcbookshelf/bookshelf/issues/523))
- ⚠️ Removed fluids from the `intangible` block tag to simplify the use of hitbox providers ([#532](https://github.com/mcbookshelf/bookshelf/pull/532))
- ✨ Updated entity hitboxes for Minecraft 26.1 ([#532](https://github.com/mcbookshelf/bookshelf/pull/532))

## `v3.2.2`

- 🐛 Fixed Nautilus entities hitboxes ([#520](https://github.com/mcbookshelf/bookshelf/pull/520))
- 🐛 Fixed fluid hitbox providers for full liquid blocks ([#519](https://github.com/mcbookshelf/bookshelf/pull/519))

## `v3.2.0`

- 🗑️ Deprecated the `has_offset` block tag in favor of `has_shape_offset` ([#484](https://github.com/mcbookshelf/bookshelf/pull/484))
- 🗑️ Deprecated `#bs.hitbox:get_block` in favor of `#bs.hitbox:get_block_shape` and `#bs.hitbox:get_block_collision` ([#484](https://github.com/mcbookshelf/bookshelf/pull/484))
- 🗑️ Deprecated the `_interaction` functions in favor of `#bs.hitbox:is_entity_in_block_shape`, `#bs.hitbox:is_entity_in_blocks_shape` and `#bs.hitbox:is_in_block_shape` ([#484](https://github.com/mcbookshelf/bookshelf/pull/484))
- ✨ Added new 1.21.11 entities ([#502](https://github.com/mcbookshelf/bookshelf/pull/502))

## `v3.1.0`

- ✨ Added support for custom hitboxes: `#bs.hitbox:get_entity` now also returns `depth` in addition to `width` ([#465](https://github.com/mcbookshelf/bookshelf/pull/465))

## `v3.0.0`

- ⚠️ Introduced `collision_shape` for block hitboxes and renamed `shape` to `interaction_shape` ([#318](https://github.com/mcbookshelf/bookshelf/issues/318))
- ⚠️ Removed `is_in_block` and `is_entity_in_block(s)` in favor of `is_in_block_<collision|interaction>` and `is_entity_in_block(s)_<collision|interaction>` ([#318](https://github.com/mcbookshelf/bookshelf/issues/318))
- ⚠️ Replaced the `is_composite` block tag with `is_full_cube` ([#297](https://github.com/mcbookshelf/bookshelf/issues/297))
- ✨ Moved the `#bs.hitbox:can_pass_through` block tag from the move module ([#299](https://github.com/mcbookshelf/bookshelf/pull/299))
- ✨ Introduced the `#bs.hitbox:is_sized` tag ([#285](https://github.com/mcbookshelf/bookshelf/pull/285))
- 🐛 Fixed functions that were previously unusable outside the Overworld ([#320](https://github.com/mcbookshelf/bookshelf/issues/320))

## `v2.2.2`

- 🐛 Fixed module issues caused by the removal of `creaking_transient` in Minecraft 1.21.4 ([#293](https://github.com/mcbookshelf/bookshelf/issues/293))

## `v2.2.0`

- ✨ Added `#bs.hitbox:is_entity_in_block` to check if an entity is in a block ([#203](https://github.com/mcbookshelf/bookshelf/issues/203))
- ✨ Added `#bs.hitbox:is_entity_in_blocks` to check if an entity is in any block ([#203](https://github.com/mcbookshelf/bookshelf/issues/203))
- ⚡ Optimized module for improved performance ([#252](https://github.com/mcbookshelf/bookshelf/pull/252))
- ⚡ Added new hitboxes (new babies and salmon variants) ([#276](https://github.com/mcbookshelf/bookshelf/pull/276))
- 🐛 Corrected hitbox for player in spectator mode ([#265](https://github.com/mcbookshelf/bookshelf/pull/265))

## `v2.0.0`

- ✨ Added a new hitbox module
