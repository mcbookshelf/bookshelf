# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

# compute the offset since we only care about bits 16 to 24, overflow of the scoreboard is not an issue
data modify storage bs:data hitbox.offsets append value {x:0,z:0,k:[0,0]}
execute store result storage bs:data hitbox.offsets[-1].k[0] int 1 run scoreboard players get #u bs.ctx
execute store result storage bs:data hitbox.offsets[-1].k[1] int 1 run scoreboard players get #v bs.ctx

# compute i = (x * 3129871) ^ (z * 116129781) - [Triton365 fast bitwise xor (using floating-point errors)]
execute store result entity @s Pos[1] double .000000007450580596923828125 run scoreboard players operation #u bs.ctx *= 3129871 bs.const
execute store result entity @s Pos[2] double .000000007450580596923828125 run scoreboard players operation #v bs.ctx *= 116129781 bs.const
execute at @s \
  positioned -.00000000186264514923095703125 ~33554496 ~33554496 facing ~ ~-.0000000037252902984619140625 ~-.0000000037252902984619140625 positioned ^ ^ ^-.00000000186264514923095703125 \
  positioned ~ ~33554431.9999999962747097015380859375 ~33554431.9999999962747097015380859375 facing ~ ~-.000000007450580596923828125 ~-.000000007450580596923828125 positioned ^ ^ ^-.0000000037252902984619140625 \
  positioned ~ ~67108863.999999992549419403076171875 ~67108863.999999992549419403076171875 facing ~ ~-.00000001490116119384765625 ~-.00000001490116119384765625 positioned ^ ^ ^-.000000007450580596923828125 \
  positioned ~ ~134217727.99999998509883880615234375 ~134217727.99999998509883880615234375 facing ~ ~-.0000000298023223876953125 ~-.0000000298023223876953125 positioned ^ ^ ^-.00000001490116119384765625 \
  positioned ~ ~268435455.9999999701976776123046875 ~268435455.9999999701976776123046875 facing ~ ~-.000000059604644775390625 ~-.000000059604644775390625 positioned ^ ^ ^-.0000000298023223876953125 \
  positioned ~ ~536870911.999999940395355224609375 ~536870911.999999940395355224609375 facing ~ ~-.00000011920928955078125 ~-.00000011920928955078125 positioned ^ ^ ^-.000000059604644775390625 \
  positioned ~ ~1073741823.99999988079071044921875 ~1073741823.99999988079071044921875 facing ~ ~-.0000002384185791015625 ~-.0000002384185791015625 positioned ^ ^ ^-.00000011920928955078125 \
  positioned ~ ~2147483647.9999997615814208984375 ~2147483647.9999997615814208984375 facing ~ ~-.000000476837158203125 ~-.000000476837158203125 positioned ^ ^ ^-.0000002384185791015625 \
  positioned ~ ~4294967295.999999523162841796875 ~4294967295.999999523162841796875 facing ~ ~-.00000095367431640625 ~-.00000095367431640625 positioned ^ ^ ^-.000000476837158203125 \
  positioned ~ ~8589934591.99999904632568359375 ~8589934591.99999904632568359375 facing ~ ~-.0000019073486328125 ~-.0000019073486328125 positioned ^ ^ ^-.00000095367431640625 \
  positioned ~ ~17179869183.9999980926513671875 ~17179869183.9999980926513671875 facing ~ ~-.000003814697265625 ~-.000003814697265625 positioned ^ ^ ^-.0000019073486328125 \
  positioned ~ ~34359738367.999996185302734375 ~34359738367.999996185302734375 facing ~ ~-.00000762939453125 ~-.00000762939453125 positioned ^ ^ ^-.000003814697265625 \
  positioned ~ ~68719476735.99999237060546875 ~68719476735.99999237060546875 facing ~ ~-.0000152587890625 ~-.0000152587890625 positioned ^ ^ ^-.00000762939453125 \
  positioned ~ ~137438953471.9999847412109375 ~137438953471.9999847412109375 facing ~ ~-.000030517578125 ~-.000030517578125 positioned ^ ^ ^-.0000152587890625 \
  positioned ~ ~274877906943.999969482421875 ~274877906943.999969482421875 facing ~ ~-.00006103515625 ~-.00006103515625 positioned ^ ^ ^-.000030517578125 \
  positioned ~ ~549755813887.99993896484375 ~549755813887.99993896484375 facing ~ ~-.0001220703125 ~-.0001220703125 positioned ^ ^ ^-.00006103515625 \
  positioned ~ ~1099511627775.9998779296875 ~1099511627775.9998779296875 facing ~ ~-.000244140625 ~-.000244140625 positioned ^ ^ ^-.0001220703125 \
  positioned ~ ~2199023255551.999755859375 ~2199023255551.999755859375 facing ~ ~-.00048828125 ~-.00048828125 positioned ^ ^ ^-.000244140625 \
  positioned ~ ~4398046511103.99951171875 ~4398046511103.99951171875 facing ~ ~-.0009765625 ~-.0009765625 positioned ^ ^ ^-.00048828125 \
  positioned ~ ~8796093022207.9990234375 ~8796093022207.9990234375 facing ~ ~-.001953125 ~-.001953125 positioned ^ ^ ^-.0009765625 \
  positioned ~ ~17592186044415.998046875 ~17592186044415.998046875 facing ~ ~-.00390625 ~-.00390625 positioned ^ ^ ^-.001953125 \
  positioned ~ ~35184372088831.99609375 ~35184372088831.99609375 facing ~ ~-.0078125 ~-.0078125 positioned ^ ^ ^-.00390625 \
  positioned ~ ~70368744177663.9921875 ~70368744177663.9921875 facing ~ ~-.015625 ~-.015625 positioned ^ ^ ^-.0078125 \
  positioned ~ ~140737488355327.984375 ~140737488355327.984375 facing ~ ~-.03125 ~-.03125 positioned ^ ^ ^-.015625 \
  positioned ~ ~281474976710655.96875 ~281474976710655.96875 facing ~ ~-.0625 ~-.0625 positioned ^ ^ ^-.03125 \
  positioned ~ ~562949953421311.9375 ~562949953421311.9375 facing ~ ~-.125 ~-.125 positioned ^ ^ ^-.0625 \
  positioned ~ ~1125899906842623.875 ~1125899906842623.875 facing ~ ~-.25 ~-.25 positioned ^ ^ ^-.125 \
  positioned ~ ~2251799813685247.75 ~2251799813685247.75 facing ~ ~-.5 ~-.5 positioned ^ ^ ^-.25 \
  positioned ~ ~4503599627370495.5 ~4503599627370495.5 facing ~ ~-1 ~-1 positioned ^ ^ ^-.5 \
  positioned ~ ~9007199254740991 ~9007199254740991 facing ~ ~-2 ~-2 positioned ^ ^ ^-1 \
  positioned ~ ~18014398509481982 ~18014398509481982 facing ~ ~-4 ~-4 positioned ^ ^ ^2 \
  run tp @s ~ 0 0.
execute store result score #i bs.ctx run data get entity @s Pos[0] 1073741824
scoreboard players operation #i bs.ctx -= #u bs.ctx
execute store result score #j bs.ctx run scoreboard players operation #i bs.ctx -= #v bs.ctx

# compute i = (i * i * 42317861) + (i * 11)
scoreboard players operation #j bs.ctx *= #j bs.ctx
scoreboard players operation #j bs.ctx *= 42317861 bs.const
scoreboard players operation #i bs.ctx *= 11 bs.const
execute store result score #u bs.ctx store result score #v bs.ctx run scoreboard players operation #i bs.ctx += #j bs.ctx

# compute offset x = (((i >> 16 & 15) / 15.0) - 0.5) * 0.5
scoreboard players operation #u bs.ctx /= 65536 bs.const
scoreboard players operation #u bs.ctx *= 268435456 bs.const
scoreboard players operation #u bs.ctx /= 268435456 bs.const
execute if score #u bs.ctx matches ..-1 run scoreboard players add #u bs.ctx 16
scoreboard players operation #u bs.ctx *= 10000000 bs.const
scoreboard players operation #u bs.ctx /= 15 bs.const
scoreboard players remove #u bs.ctx 5000000
scoreboard players operation #u bs.ctx /= 2 bs.const

# compute offset z = (((i >> 24 & 15) / 15.0) - 0.5) * 0.5
scoreboard players operation #v bs.ctx /= 16777216 bs.const
scoreboard players operation #v bs.ctx *= 268435456 bs.const
scoreboard players operation #v bs.ctx /= 268435456 bs.const
execute if score #v bs.ctx matches ..-1 run scoreboard players add #v bs.ctx 16
scoreboard players operation #v bs.ctx *= 10000000 bs.const
scoreboard players operation #v bs.ctx /= 15 bs.const
scoreboard players remove #v bs.ctx 5000000
scoreboard players operation #v bs.ctx /= 2 bs.const

# cache the result for better performance in future calls
execute store result storage bs:out hitbox.offset.x double .0000001 run scoreboard players get #u bs.ctx
execute store result storage bs:out hitbox.offset.z double .0000001 run scoreboard players get #v bs.ctx
data modify storage bs:data hitbox.offsets[-1] merge from storage bs:out hitbox.offset
