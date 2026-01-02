# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:ctx _.points prepend value [0d,0d,0d]
execute store result score #u bs.ctx run data get storage bs:ctx _.points[1][0] 1000
execute store result score #v bs.ctx run data get storage bs:ctx _.points[2][0] 1000
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[0][0] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx
execute store result score #u bs.ctx run data get storage bs:ctx _.points[1][1] 1000
execute store result score #v bs.ctx run data get storage bs:ctx _.points[2][1] 1000
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[0][1] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx
execute store result score #u bs.ctx run data get storage bs:ctx _.points[1][2] 1000
execute store result score #v bs.ctx run data get storage bs:ctx _.points[2][2] 1000
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[0][2] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx

data modify storage bs:ctx _.points append value [0d,0d,0d]
execute store result score #u bs.ctx run data get storage bs:ctx _.points[-3][0]
execute store result score #v bs.ctx run data get storage bs:ctx _.points[-2][0]
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[-1][0] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx
execute store result score #u bs.ctx run data get storage bs:ctx _.points[-3][1]
execute store result score #v bs.ctx run data get storage bs:ctx _.points[-2][1]
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[-1][1] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx
execute store result score #u bs.ctx run data get storage bs:ctx _.points[-3][2]
execute store result score #v bs.ctx run data get storage bs:ctx _.points[-2][2]
scoreboard players operation #v bs.ctx -= #u bs.ctx
execute store result storage bs:ctx _.points[-1][2] double .001 run scoreboard players operation #u bs.ctx -= #v bs.ctx

function bs.animation:utils/def/3d/catmull_rom
