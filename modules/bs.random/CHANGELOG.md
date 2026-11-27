# 🎲 Random

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions: no more scores, every feature reads its storage `in` and the functions write to `out` ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ `uniform`, `binomial`, `geometric` and `poisson` are now integer providers: compute them with `compute default integer bs.random:<name>` instead of calling a function ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ `normal` is now a float provider: compute it with `compute default float bs.random:normal`. It gives fractions, with no scaling of the mean or of the spread ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ `#bs.random:simplex_noise_2d` and `#bs.random:fractal_noise_2d` are now `#bs.random:simplex_noise/2d` and `#bs.random:fractal_noise/2d`: they take `pos`, a list of 2 block coordinates, and a cell `size` instead of coordinates scaled by 1000, and give a float from `-1` to `1` in `out` instead of an integer from `-1000` to `1000`. The noise itself changed: the same seed gives other values than before ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ `#bs.random:fractal_noise/2d` takes at most 16 octaves, a `persistence` and a `lacunarity` as floats instead of values scaled by 1000 ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ Removed `#bs.random:white_noise_mat_1d`, `#bs.random:white_noise_mat_2d`, `#bs.random:simplex_noise_mat_2d` and `#bs.random:fractal_noise_mat_2d`: call the noise from a loop of your own, or use `uniform` for white noise ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ⚠️ `#bs.random:weighted_choice` takes at most 256 values ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ✨ `bs.random:binomial` takes any number of trials, no longer limited to 1000 ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ✨ `bs.random:geometric` counts up to 65536 trials instead of 1000 ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ✨ `bs.random:uniform` is also a float provider: compute it with `compute default float bs.random:uniform` to get fractions ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))
- ✨ Added `#bs.random:simplex_noise/1d`, `#bs.random:simplex_noise/3d`, `#bs.random:fractal_noise/1d` and `#bs.random:fractal_noise/3d`: the noise on a line and in a volume ([#612](https://github.com/mcbookshelf/bookshelf/pull/612))

## `v3.2.1`

- 🐛 `#bs.random:choice` no longer rarely selects the last option ([#514](https://github.com/mcbookshelf/bookshelf/issues/514))

## `v3.1.0`

- ✨ Added `#bs.random:normal` to generate numbers from a normal distribution ([#286](https://github.com/mcbookshelf/bookshelf/issues/286))
- 🐛 Location-based loot tables run in the overworld ([#469](https://github.com/mcbookshelf/bookshelf/issues/469))

## `v2.2.0`

- 🎉 Added the module, with random distributions, noise generation, and random selection of an element from a list ([#1](https://github.com/mcbookshelf/bookshelf/issues/1), [#220](https://github.com/mcbookshelf/bookshelf/issues/220))
