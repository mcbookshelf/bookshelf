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

data modify storage bs:ctx _ set from storage bs:in spline.evaluate_bezier
data modify storage bs:out spline.evaluate_bezier set value []

execute store result score #s bs.ctx store result score #t bs.ctx run data get storage bs:ctx _.time 1000
scoreboard players operation #s bs.ctx /= 1000 bs.const
execute if score #s bs.ctx matches 1.. run function bs.spline:utils/bezier/get_segment

execute store result score #m bs.ctx if data storage bs:ctx _.points[]
execute store result score #n bs.ctx if data storage bs:ctx _.points[][2]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:evaluate/evaluate_3d {type:"bezier"}
execute store result score #n bs.ctx if data storage bs:ctx _.points[][1]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:evaluate/evaluate_2d {type:"bezier"}
execute store result score #n bs.ctx if data storage bs:ctx _.points[][0]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:evaluate/evaluate_1d {type:"bezier"}
