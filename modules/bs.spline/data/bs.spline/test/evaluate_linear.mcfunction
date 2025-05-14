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

data modify storage bs:in spline.evaluate_linear set value {points:[[-39.51, 99.914, 53.16], [-65.788, -99.526, -13.28], [-59.734, 82.879, -69.759], [-28.352, -50.677, 79.867]],time:0.124}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches -42770..-42766
assert score #y bs.ctx matches 75181..75185
assert score #z bs.ctx matches 44919..44923

data modify storage bs:in spline.evaluate_linear set value {points:[[-2.476, -97.226, -9.416], [51.826, -45.883, -54.268], [-24.309, -47.473, 46.058], [-82.18, -26.204, 42.502]],time:0.177}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches 7133..7137
assert score #y bs.ctx matches -88140..-88136
assert score #z bs.ctx matches -17357..-17353

data modify storage bs:in spline.evaluate_linear set value {points:[[-9.712, 47.595, -86.768], [-25.875, -29.768, -52.993], [27.22, -60.536, 8.376], [57.077, -84.618, 15.88]],time:0.797}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches -22596..-22592
assert score #y bs.ctx matches -14065..-14061
assert score #z bs.ctx matches -59851..-59847

data modify storage bs:in spline.evaluate_linear set value {points:[[-75.69, -26.617, -81.958], [37.627, -11.579, 51.195], [58.928, -41.345, -88.421], [-8.079, 99.256, 79.53]],time:0.015}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches -73992..-73988
assert score #y bs.ctx matches -26393..-26389
assert score #z bs.ctx matches -79963..-79959

data modify storage bs:in spline.evaluate_linear set value {points:[[-65.211, 94.008, 34.896], [-30.85, -91.129, 42.052], [-8.961, -88.462, -93.511], [25.096, -83.628, 1.18]],time:0.47}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches -49063..-49059
assert score #y bs.ctx matches 6992..6996
assert score #z bs.ctx matches 38257..38261

data modify storage bs:in spline.evaluate_linear set value {points:[[68.583, -25.938, -33.139], [-5.84, -98.794, 28.603], [35.048, -45.817, -34.14], [-21.087, 50.688, -37.148]],time:0.865}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches 4205..4209
assert score #y bs.ctx matches -88960..-88956
assert score #z bs.ctx matches 20266..20270

data modify storage bs:in spline.evaluate_linear set value {points:[[27.959, -82.031, -77.959], [2.009, 95.36, 35.831], [91.374, 30.945, 30.083], [29.334, -20.517, 99.017]],time:0.891}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches 4836..4840
assert score #y bs.ctx matches 76022..76026
assert score #z bs.ctx matches 23426..23430

data modify storage bs:in spline.evaluate_linear set value {points:[[37.603, 77.412, 34.733], [93.945, -9.934, 25.572], [75.079, -66.74, -68.449], [-64.827, 19.624, 93.37]],time:0.626}
function #bs.spline:evaluate_linear
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_linear[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_linear[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_linear[2] 1000
assert score #x bs.ctx matches 72871..72875
assert score #y bs.ctx matches 22731..22735
assert score #z bs.ctx matches 28996..29000
