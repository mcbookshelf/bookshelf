# 🎨 Color

## Unreleased

- ⚠️ Inputs and outputs were completely reworked to follow new conventions ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ⚠️ Removed the score outputs: results are written to the storage of each function, and `hex_to_int` and `rgb_to_int` also return them ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ⚠️ A list of channels holds floats from `0` to `1` instead of integers from `0` to `255`: `[1.0,0.5,0.0]`, not `[255,128,0]` ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ✨ `#bs.color:hex_to_int`, `#bs.color:hex_to_rgb`, `#bs.color:rgb_to_hex` and `#bs.color:rgb_to_int` accept a color with an alpha ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ✨ Added `#bs.color:int_to_hexa` and `#bs.color:int_to_rgba` to convert an ARGB integer with its alpha, to `#rrggbbaa` and `[r,g,b,a]` ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ✨ Added the `bs.color:mix` and `bs.color:mix_oklab` integer providers to get a color between two others, the second one in the Oklab color space ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ✨ A hexadecimal color can mix lowercase and uppercase digits ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))
- ⚡ Conversions are computed with number providers, without any score ([#579](https://github.com/mcbookshelf/bookshelf/pull/579))

## `v2.0.0`

- ⚠️ Inputs and outputs were reworked to follow new conventions
- ✨ Added `#bs.color:hex_to_int`, `#bs.color:hex_to_rgb`, `#bs.color:int_to_hex` and `#bs.color:rgb_to_hex` to convert hexadecimal colors

## `v1.0.0`

- ⚙️ Load error `TooLazyException`: our devs are too busy coding the future to dig up the past...
