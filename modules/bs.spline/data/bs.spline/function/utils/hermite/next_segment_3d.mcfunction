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

data modify storage bs:lambda spline.point set value [0d, 0d, 0d]
execute store result score #x bs.ctx store result score #y bs.ctx store result score #z bs.ctx run scoreboard players operation #t bs.ctx %= 1000 bs.const

execute store result score #a bs.ctx run data get storage bs:ctx _.points[0][0] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[1][0] 1000
execute store result score #c bs.ctx run data get storage bs:ctx _.points[2][0] 1000
execute store result score #d bs.ctx run data get storage bs:ctx _.points[3][0] 1000

execute store result score #e bs.ctx run data get storage bs:ctx _.points[0][1] 1000
execute store result score #f bs.ctx run data get storage bs:ctx _.points[1][1] 1000
execute store result score #g bs.ctx run data get storage bs:ctx _.points[2][1] 1000
execute store result score #h bs.ctx run data get storage bs:ctx _.points[3][1] 1000

execute store result score #i bs.ctx run data get storage bs:ctx _.points[0][2] 1000
execute store result score #j bs.ctx run data get storage bs:ctx _.points[1][2] 1000
execute store result score #k bs.ctx run data get storage bs:ctx _.points[2][2] 1000
execute store result score #l bs.ctx run data get storage bs:ctx _.points[3][2] 1000

# Make points relative to prevent overflow
scoreboard players operation #b bs.ctx -= #a bs.ctx
scoreboard players operation #c bs.ctx -= #a bs.ctx
execute store result score #u bs.ctx run scoreboard players operation #d bs.ctx -= #a bs.ctx

scoreboard players operation #f bs.ctx -= #e bs.ctx
scoreboard players operation #g bs.ctx -= #e bs.ctx
execute store result score #v bs.ctx run scoreboard players operation #h bs.ctx -= #e bs.ctx

scoreboard players operation #j bs.ctx -= #i bs.ctx
scoreboard players operation #k bs.ctx -= #i bs.ctx
execute store result score #w bs.ctx run scoreboard players operation #l bs.ctx -= #i bs.ctx

# Compute Hermite coefficients
scoreboard players operation #d bs.ctx += #c bs.ctx
scoreboard players operation #c bs.ctx *= 4 bs.const
scoreboard players operation #d bs.ctx -= #c bs.ctx
scoreboard players operation #d bs.ctx += #b bs.ctx
scoreboard players operation #c bs.ctx -= #b bs.ctx
scoreboard players operation #c bs.ctx -= #b bs.ctx
scoreboard players operation #c bs.ctx -= #u bs.ctx

scoreboard players operation #h bs.ctx += #g bs.ctx
scoreboard players operation #g bs.ctx *= 4 bs.const
scoreboard players operation #h bs.ctx -= #g bs.ctx
scoreboard players operation #h bs.ctx += #f bs.ctx
scoreboard players operation #g bs.ctx -= #f bs.ctx
scoreboard players operation #g bs.ctx -= #f bs.ctx
scoreboard players operation #g bs.ctx -= #v bs.ctx

scoreboard players operation #l bs.ctx += #k bs.ctx
scoreboard players operation #k bs.ctx *= 4 bs.const
scoreboard players operation #l bs.ctx -= #k bs.ctx
scoreboard players operation #l bs.ctx += #j bs.ctx
scoreboard players operation #k bs.ctx -= #j bs.ctx
scoreboard players operation #k bs.ctx -= #j bs.ctx
scoreboard players operation #k bs.ctx -= #w bs.ctx

data remove storage bs:ctx _.points[0]
data remove storage bs:ctx _.points[0]
