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

data modify storage bs:ctx _._ append value {f:"linear",p:[0,0,0,0,0,0],t:0,d:0}
execute if score #n bs.ctx matches 0 run data modify storage bs:ctx _._[-1].d set from storage bs:ctx _.duration[0]
execute if score #n bs.ctx matches 0 run data remove storage bs:ctx _.duration[0]

# Compute Linear coefficients (X)
execute store result score #a bs.ctx store result storage bs:ctx _._[-1].p[0] int 1 run data get storage bs:ctx _.points[0][0] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[1][0] 1000
execute store result storage bs:ctx _._[-1].p[1] int 1 run scoreboard players operation #b bs.ctx -= #a bs.ctx

# Compute Linear coefficients (Y)
execute store result score #a bs.ctx store result storage bs:ctx _._[-1].p[2] int 1 run data get storage bs:ctx _.points[0][1] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[1][1] 1000
execute store result storage bs:ctx _._[-1].p[3] int 1 run scoreboard players operation #b bs.ctx -= #a bs.ctx

# Compute Linear coefficients (Z)
execute store result score #a bs.ctx store result storage bs:ctx _._[-1].p[4] int 1 run data get storage bs:ctx _.points[0][2] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[1][2] 1000
execute store result storage bs:ctx _._[-1].p[5] int 1 run scoreboard players operation #b bs.ctx -= #a bs.ctx

data remove storage bs:ctx _.points[0]

execute if data storage bs:ctx _.points[1] run function bs.animation:utils/def/3d/linear
