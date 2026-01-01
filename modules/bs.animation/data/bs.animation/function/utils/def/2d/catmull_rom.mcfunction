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

data modify storage bs:ctx _._ append value {f:"cubic",p:[0,0,0,0,0,0,0,0],t:0,d:0}
execute if score #n bs.ctx matches 0 run data modify storage bs:ctx _._[-1].d set from storage bs:ctx _.duration[0]
execute if score #n bs.ctx matches 0 run data remove storage bs:ctx _.duration[0]

# Compute Catmull-Rom coefficients (X)
execute store result score #a bs.ctx run data get storage bs:ctx _.points[0][0] 1000
execute store result score #c bs.ctx run data get storage bs:ctx _.points[1][0] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[2][0] 1000
execute store result score #d bs.ctx run data get storage bs:ctx _.points[3][0] 1000
execute store result score #u bs.ctx run scoreboard players operation #b bs.ctx -= #a bs.ctx
scoreboard players operation #c bs.ctx -= #a bs.ctx
scoreboard players operation #d bs.ctx -= #a bs.ctx
execute store result storage bs:ctx _._[-1].p[0] int 1 run scoreboard players operation #a bs.ctx += #c bs.ctx
scoreboard players operation #d bs.ctx += #c bs.ctx
scoreboard players operation #c bs.ctx *= -2 bs.const
scoreboard players operation #d bs.ctx -= #c bs.ctx
scoreboard players operation #u bs.ctx *= 3 bs.const
scoreboard players operation #d bs.ctx -= #u bs.ctx
scoreboard players operation #c bs.ctx += #b bs.ctx
scoreboard players operation #c bs.ctx -= #d bs.ctx
execute store result storage bs:ctx _._[-1].p[1] int 1 run scoreboard players operation #b bs.ctx /= 2 bs.const
execute store result storage bs:ctx _._[-1].p[2] int 1 run scoreboard players operation #c bs.ctx /= 2 bs.const
execute store result storage bs:ctx _._[-1].p[3] int 1 run scoreboard players operation #d bs.ctx /= 2 bs.const

# Compute Catmull-Rom coefficients (Y)
execute store result score #a bs.ctx run data get storage bs:ctx _.points[0][1] 1000
execute store result score #c bs.ctx run data get storage bs:ctx _.points[1][1] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[2][1] 1000
execute store result score #d bs.ctx run data get storage bs:ctx _.points[3][1] 1000
execute store result score #u bs.ctx run scoreboard players operation #b bs.ctx -= #a bs.ctx
scoreboard players operation #c bs.ctx -= #a bs.ctx
scoreboard players operation #d bs.ctx -= #a bs.ctx
execute store result storage bs:ctx _._[-1].p[4] int 1 run scoreboard players operation #a bs.ctx += #c bs.ctx
scoreboard players operation #d bs.ctx += #c bs.ctx
scoreboard players operation #c bs.ctx *= -2 bs.const
scoreboard players operation #d bs.ctx -= #c bs.ctx
scoreboard players operation #u bs.ctx *= 3 bs.const
scoreboard players operation #d bs.ctx -= #u bs.ctx
scoreboard players operation #c bs.ctx += #b bs.ctx
scoreboard players operation #c bs.ctx -= #d bs.ctx
execute store result storage bs:ctx _._[-1].p[5] int 1 run scoreboard players operation #b bs.ctx /= 2 bs.const
execute store result storage bs:ctx _._[-1].p[6] int 1 run scoreboard players operation #c bs.ctx /= 2 bs.const
execute store result storage bs:ctx _._[-1].p[7] int 1 run scoreboard players operation #d bs.ctx /= 2 bs.const

data remove storage bs:ctx _.points[0]

execute if data storage bs:ctx _.points[3] run function bs.animation:utils/def/2d/catmull_rom
