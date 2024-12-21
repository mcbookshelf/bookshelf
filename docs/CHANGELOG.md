# 🛠️ Changelog

---

## 📦 Bookshelf - 2.2.1

Bookshelf is now based on **Minecraft 1.21.4**.

### 🐛 Fixes
- **[#288](https://github.com/Gunivers/Bookshelf/issues/288)** Fix `bs.move` collisions.
- **[#290](https://github.com/Gunivers/Bookshelf/issues/290)** Add missing blocks in `bs.block` registries.

## 📦 Bookshelf - 2.2.0

```{epigraph}
**🪐 The dimensional update!**

*This release features new modules for random distribution and terrain generation, refinements to existing modules, performance enhancements, and minor bug resolutions. Additionally, this update aims to ensure all functions work seamlessly across all dimensions.*
```

Bookshelf is now based on **Minecraft 1.21.3**.

### 🎉 Added modules

- **[#1](https://github.com/Gunivers/Bookshelf/issues/1)** / **[#220](https://github.com/Gunivers/Bookshelf/issues/220)** Added the `bs.random` module, which includes:
  - Random distributions: uniform, binomial, geometric, and Poisson.
  - Noise generation functions: white, simplex, and fractal.
  - Random selection of an element from a list.
- **[#6](https://github.com/Gunivers/Bookshelf/issues/6)** Added the `bs.generate` module for terrain generation. Currently supports 2D shape algorithms, enabling texture and heightmap-based terrain generation.
- **[#193](https://github.com/Gunivers/Bookshelf/issues/193)** Added the `bs.interaction` module, which proposes interactions to listen to different players' events: left click, right click, hover (enter, leave and continuous).

### ✨ Added features

- **[#222](https://github.com/Gunivers/Bookshelf/issues/222)** Added `#bs.block:fill_random` for filling regions with randomly selected blocks.
- **[#258](https://github.com/Gunivers/Bookshelf/issues/258)** Added `#bs.block:emit_block_particle` to emit block particles in specific locations.
- **[#245](https://github.com/Gunivers/Bookshelf/issues/245)** Added `piercing` and callback options to `#bs.raycast:run`.
- **[#203](https://github.com/Gunivers/Bookshelf/issues/203)** Added `#bs.hitbox:is_entity_in_block` and `#bs.hitbox:is_entity_in_blocks` to verify if an entity is within a block.
- **[#233](https://github.com/Gunivers/Bookshelf/issues/233)** Introduced new link management functions:
  - `#bs.link:remove_link` to remove specific links.
  - `#bs.link:as_children`, `#bs.link:as_parent`, `#bs.link:at_children`, and `#bs.link:at_parent` to handle parent-child link relationships.
- **[#171](https://github.com/Gunivers/Bookshelf/issues/171)** Added logging functions `#bs.log:history` and `#bs.log:clear_history` for viewing and clearing log history.

### 🔁 Tweaks

- **[#251](https://github.com/Gunivers/Bookshelf/issues/251)** Enhanced `bs.block` fill functions to accept `from` and `to` inputs as either `[x, y, z]` lists or as stringified coordinates (e.g., `~ ~5 25`).
- **[#247](https://github.com/Gunivers/Bookshelf/pull/247)** Improved the default `bs.log` format for clarity.
- **[#252](https://github.com/Gunivers/Bookshelf/pull/252)** Optimized `bs.hitbox` module for improved performance.
- **[#265](https://github.com/Gunivers/Bookshelf/pull/265)** Optimized `bs.schedule` module for improved performance.
- **[#265](https://github.com/Gunivers/Bookshelf/pull/265)** Enabled `bs.move` module to function effectively at higher coordinate ranges. Collision detection has also been improved and should be more robust.
- **[#265](https://github.com/Gunivers/Bookshelf/pull/265)** Load tags do not load modules in isolation anymore. This can now be done using the `exclusive_load` tag.
- **[#276](https://github.com/Gunivers/Bookshelf/pull/276)** Add new hitboxes (new babies and salmon variants).

### 🐛 Fixes

- **[#254](https://github.com/Gunivers/Bookshelf/issues/254)** Resolved execution loop interruptions caused by `#bs.schedule:schedule` callbacks.
- **[#243](https://github.com/Gunivers/Bookshelf/issues/243)** Fixed unload functions for `bs.health` and `bs.move`.
- **[#264](https://github.com/Gunivers/Bookshelf/issues/264)** Resolved compatibility issues with the schedule module outside the overworld.
- **[#255](https://github.com/Gunivers/Bookshelf/issues/255)** Fixed `bs.move` local velocity collisions.
- **[#262](https://github.com/Gunivers/Bookshelf/pull/262)** Resolved collision issues with paintings for `bs.raycast` and `bs.move`.
- **[#256](https://github.com/Gunivers/Bookshelf/issues/256)** Fixed XP progress boundary issues at 0% and 100%.
- **[#265](https://github.com/Gunivers/Bookshelf/pull/265)** Corrected hitbox for player in spectator mode.
- **[#270](https://github.com/Gunivers/Bookshelf/issues/270)** Enabled all modules to function across any dimension.


---

## 📦 Bookshelf - 2.1.1

### 🔁 Tweaks
- **[#238](https://github.com/Gunivers/Bookshelf/pull/238)** Load tags now load modules in isolation.
- **[#237](https://github.com/Gunivers/Bookshelf/pull/237)** Enhanced speed of `bs.block` module.
- **[#218](https://github.com/Gunivers/Bookshelf/pull/218)** Enhanced speed of factorial function in `bs.math`.

### 🐛 Fixes
- **[#236](https://github.com/Gunivers/Bookshelf/issues/236)** Fix `bs.block`, `bs.id` and `bs.math` load functions.
- **[#235](https://github.com/Gunivers/Bookshelf/issues/235)** Fix `bs.block` inputs that required extra escaping.

### 📄 Documentation
- **[#215](https://github.com/Gunivers/Bookshelf/issues/215)** There is now documentation about the documentation (kind of metadocumentation?).

---

## 📦 Bookshelf - 2.1.0

Bookshelf is now based on **Minecraft 1.21**.

### 🎉 Addition
- **[#187](https://github.com/Gunivers/Bookshelf/issues/187)** Add `#bs.block:map_type` and `#bs.block:mix_type` functions.

### 🐛 Fixes
- **[#211](https://github.com/Gunivers/Bookshelf/pull/211)** Add missing help function tag in `bs.link`.
- **[#211](https://github.com/Gunivers/Bookshelf/pull/211)** Add missing help function tag in `bs.vector`.
- **[#211](https://github.com/Gunivers/Bookshelf/pull/211)** Add missing help function tag in `bs.xp`.

### 📄 Documentation
- **[#206](https://github.com/Gunivers/Bookshelf/issues/206)** Add new related datapacks and mods.
- **[#208](https://github.com/Gunivers/Bookshelf/issues/208)** Add missing documentation for documentation for feature `bs.position:get_pos_and_rot`.
- **[#208](https://github.com/Gunivers/Bookshelf/issues/208)** Add missing documentation for documentation for feature `bs.position:set_pos_and_rot`.
- **[#208](https://github.com/Gunivers/Bookshelf/issues/208)** Add missing documentation for documentation for feature `bs.position:add_pos_and_rot`.

### 📋 Conventions
- **[#200](https://github.com/Gunivers/Bookshelf/issues/200)** We throw away the old feature function header to a new one with only the licence. This header is now mandatory for all functions. All the metadata that was present inside the old one have been moved to the feature function tag.
- **[#52](https://github.com/Gunivers/Bookshelf/issues/52)** / **[#175](https://github.com/Gunivers/Bookshelf/issues/175)** Each module has now its own metadata that should be specified manually. The metadata of the features and modules are used to generate more metadata, including the dependencies. These metadata can be used by bots like the incomming Bookshelf Manager. More information [here](project:contribute/metadata.md).

### ⚙️ Github and CI
- Added a template for pull requests.
- Added templates for issues.
- **[#199](https://github.com/Gunivers/Bookshelf/pull/199)** The different metadata (the manually specified one and the generated one) are now automatically verified at each commit inside a pull request. This prevents them from being forgotten. More information [here](project:contribute/contribution-validation.md).

---

## 📦 Bookshelf - 2.0.0

```{admonition} Breaking changes
:class: warning

This new version is filled with breaking changes. Since maintaining a list of those became unrealistic, the following changelog only highlights a selection of tweaks and new functionalities.
```

### 🎉 Addition
- There is now a changelog!
- Added player health manipulation.
- Added precise collisions (move, raycast and view).
- Added float manipulation (frexp and ldexp).
- Added a new hitbox module.
- Added a new raycast module.
- Added a new sidebar module.

### 🔁 Tweaks
- The project has a new fresh identity: Bookshelf.
- Every module has been reworked for improved accuracy, performance, and/or simplicity.
- Renamed almost everything (scores, objectives, functions, ...).
- Many functions now utilize macros, storage, or fake scores instead of objectives.
- Removed the core module. The library no longer requires a base module.
- Removed outdated modules (cache, item, mapedit, and memory).
- Merged the location and orientation modules into a new position module.
- Bitwise operations have been moved out of the math module into a separate module.
- Enhanced the accuracy of the move and view modules due to their rework and the addition of the new hitbox module.
- The schedule module now maintains the current execution context.

### 🐛 Bug fixes
- Who knows at this point 🤷‍♂️, almost no legacy code remains...

---

## 📦 Gunivers Lib - 1.0.0

Data load error: TooLazyException

Our devs are too busy coding the future to dig up the past...
