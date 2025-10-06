## 📦 Bookshelf - Unreleased

### `🧱 bs.block`

- <abbr title="Deprecations">🗑️</abbr> **[#489](https://github.com/mcbookshelf/bookshelf/pull/489)** - Deprecated `play_block_sound` in favor of more granular functions (`play_break_sound`, etc.).
- <abbr title="New Features">✨</abbr> **[#489](https://github.com/mcbookshelf/bookshelf/pull/489)** - Added new block property functions: `get_blast_resistance`, `get_friction`, `get_hardness`, `get_instrument`, `get_jump_factor`, `get_luminance`, `get_sounds`, `get_speed_factor`, `is_conductive`, and `is_spawnable`.
- <abbr title="New Features">✨</abbr> **[#489](https://github.com/mcbookshelf/bookshelf/pull/489)** - Added new block sound functions: `play_break_sound`, `play_hit_sound`, `play_fall_sound`, `play_place_sound`, and `play_step_sound`.
- <abbr title="New Features">✨</abbr> **[#489](https://github.com/mcbookshelf/bookshelf/pull/489)** - Added new block tags: `can_occlude` and `ignited_by_lava`.
- <abbr title="Enhancements">⚡</abbr> **[#489](https://github.com/mcbookshelf/bookshelf/pull/489)** - Modified `emit_block_particle` to support a default `type`, aligning it with the new block sound function behavior.

### `🎯 bs.hitbox`

- <abbr title="Deprecations">🗑️</abbr> - Block tag `has_offset` has been **deprecated** and will be removed in a v4.0.0. Please use `has_shape_offset` instead.
- <abbr title="Deprecations">🗑️</abbr> - Function `#bs.hitbox:get_block` has been **deprecated** and will be removed in a v4.0.0. Please use `#bs.hitbox:get_block_shape` or `#bs.hitbox:get_block_collision` instead.
- <abbr title="Deprecations">🗑️</abbr> - Functions `#bs.hitbox:is_entity_in_block_interaction`, `#bs.hitbox:is_entity_in_blocks_interaction`, and `#bs.hitbox:is_in_block_interaction` have been **deprecated** and will be removed in a v4.0.0. Please use `#bs.hitbox:is_entity_in_block_shape`, `#bs.hitbox:is_entity_in_blocks_shape`, or `#bs.hitbox:is_in_block_shape` instead.


### `🏃 bs.move`

- <abbr title="Bug Fix">🐛</abbr> **[#487](https://github.com/mcbookshelf/bookshelf/issues/487)** - Prevent false collision on zero-velocity axes with partial blocks like slabs
