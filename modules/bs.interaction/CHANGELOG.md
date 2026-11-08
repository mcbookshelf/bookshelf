# 🖱️ Interaction

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))
- ⚠️ Events no longer return a generated id: give them a string `id` to clear them with, and they succeed when registered ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))
- ⚠️ `executor` takes a selector directly, such as `executor:"@n[tag=my_pack.icon]"`, and `lazy` moved to the optional arguments: `with:{lazy:false}` ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))
- ⚠️ `#bs.interaction:clear_events` takes the `type` and `id` to clear as optional arguments: `{with:{type:"hover",id:"my_pack:menu"}}` ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))
- ⚠️ Removed `#bs.interaction:callback/<glow|unglow|none>`: run the command directly, such as `data modify entity @s Glowing set value true` ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))
- 🐛 An interaction keeps its `bs.interaction.hovered` tag when one of the players looking at it logs out ([#609](https://github.com/mcbookshelf/bookshelf/pull/609))

## `v3.1.0`

- 🐛 Fixed left and right click events targeting a previously clicked entity instead of the current one ([#463](https://github.com/mcbookshelf/bookshelf/issues/463))

## `v3.0.0`

- ✨ Added the `bs.interaction.hovered` tag to check if an interaction is hovered ([#300](https://github.com/mcbookshelf/bookshelf/issues/300))

## `v2.2.0`

- 🎉 Added the module, to run commands when players click or hover interaction entities ([#193](https://github.com/mcbookshelf/bookshelf/issues/193))
