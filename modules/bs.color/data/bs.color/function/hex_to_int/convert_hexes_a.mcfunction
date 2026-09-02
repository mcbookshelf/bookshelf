# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
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

$execute store result score #c bs.ctx run compute default {type:"minecraft:sum",operands:[{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(z)"},{type:"minecraft:product",operands:[256,{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(y)"}]},{type:"minecraft:product",operands:[65536,{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(x)"}]}]} integer

$execute store result score #a bs.ctx run data get storage bs:const color.hex_values.$(w)
scoreboard players operation #a bs.ctx *= 16777216 bs.const

return run execute store result storage bs:out color.hex_to_int int 1 run scoreboard players operation #c bs.ctx += #a bs.ctx
