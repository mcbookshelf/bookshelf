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

data modify storage bs:in spline.evaluate_bspline set value {points:[[24.244, 4.014, 41.385], [9.416, -75.964, -50.292], [18.308, 70.946, -61.604], [23.058, -93.921, -23.028]],time:0.625}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches 15011..15015
assert score #y bs.ctx matches 5161..5165
assert score #z bs.ctx matches -54628..-54624

data modify storage bs:in spline.evaluate_bspline set value {points:[[82.914, 34.47, 67.595], [35.494, 49.67, 22.43], [35.405, -72.927, 24.074], [-47.266, 27.647, 48.604]],time:0.135}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches 40552..40556
assert score #y bs.ctx matches 18345..18349
assert score #z bs.ctx matches 27709..27713

data modify storage bs:in spline.evaluate_bspline set value {points:[[73.828, -92.636, 71.888], [-37.244, 28.545, -17.223], [0.642, 65.579, -71.692], [-1.783, -94.558, -5.6]],time:0.385}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches -17268..-17264
assert score #y bs.ctx matches 37664..37668
assert score #z bs.ctx matches -35706..-35702

data modify storage bs:in spline.evaluate_bspline set value {points:[[42.057, 60.91, -66.396], [45.443, -9.776, 58.616], [-35.802, 59.18, 60.545], [75.087, 24.229, -36.197]],time:0.993}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches -3881..-3877
assert score #y bs.ctx matches 41739..41743
assert score #z bs.ctx matches 44427..44431

data modify storage bs:in spline.evaluate_bspline set value {points:[[86.812, -63.659, -41.176], [-25.163, -10.11, -95.854], [-2.799, 61.102, -68.094], [-52.974, 47.162, -15.232]],time:0.193}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches -9169..-9165
assert score #y bs.ctx matches 5077..5081
assert score #z bs.ctx matches -83247..-83243

data modify storage bs:in spline.evaluate_bspline set value {points:[[-37.696, -88.52, 63.282], [-10.383, 75.23, 3.529], [93.459, 0.491, -62.011], [91.989, 35.738, 29.884]],time:0.763}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches 61220..61224
assert score #y bs.ctx matches 25816..25820
assert score #z bs.ctx matches -34838..-34834

data modify storage bs:in spline.evaluate_bspline set value {points:[[52.496, 1.286, 44.401], [-73.652, 88.356, 24.391], [-25.806, -13.215, -92.166], [-58.655, -62.695, 54.949]],time:0.368}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches -49397..-49393
assert score #y bs.ctx matches 43472..43476
assert score #z bs.ctx matches -20376..-20372

data modify storage bs:in spline.evaluate_bspline set value {points:[[40.471, -37.537, -93.869], [-54.988, 17.266, 68.274], [-13.822, 84.605, 73.338], [-92.62, 16.108, -56.096]],time:0.789}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bspline[2] 1000
assert score #x bs.ctx matches -32117..-32113
assert score #y bs.ctx matches 59294..59298
assert score #z bs.ctx matches 61011..61015
