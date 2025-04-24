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

data modify storage bs:in spline.evaluate_bezier set value {points:[[64.785, 4.705, 50.587], [-71.634, 55.195, 2.907], [-23.545, -33.873, 71.108], [38.042, -89.927, 25.889]],time:0.313}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches -14330..-14326
assert score #y bs.ctx matches 16388..16392
assert score #z bs.ctx matches 32840..32844

data modify storage bs:in spline.evaluate_bezier set value {points:[[-27.525, 56.095, -11.872], [9.349, 28.978, 67.016], [-63.984, -64.11, 98.773], [73.549, 93.367, -62.082]],time:0.469}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches -15247..-15243
assert score #y bs.ctx matches 7061..7065
assert score #z bs.ctx matches 53012..53016

data modify storage bs:in spline.evaluate_bezier set value {points:[[90.175, -84.328, 58.944], [-97.564, 18.333, -29.886], [-48.731, 37.517, -2.049], [-84.821, 30.197, 9.181]],time:0.558}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches -58979..-58975
assert score #y bs.ctx matches 19448..19452
assert score #z bs.ctx matches -3937..-3933

data modify storage bs:in spline.evaluate_bezier set value {points:[[94.161, -16.992, -8.139], [29.825, 77.95, 41.261], [87.479, 79.652, -98.129], [-3.48, -45.417, 18.823]],time:0.643}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches 49426..49430
assert score #y bs.ctx matches 41585..41589
assert score #z bs.ctx matches -28676..-28672

data modify storage bs:in spline.evaluate_bezier set value {points:[[-65.14, 53.725, 22.476], [-12.9, -29.19, -9.797], [70.284, -67.485, -23.859], [-88.474, 83.88, -90.663]],time:0.662}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches 121..125
assert score #y bs.ctx matches -10204..-10200
assert score #z bs.ctx matches -38262..-38258

data modify storage bs:in spline.evaluate_bezier set value {points:[[97.889, -64.463, -21.042], [7.604, -12.778, -79.174], [40.714, -14.365, 40.136], [99.31, -18.692, 34.775]],time:0.218}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches 55419..55423
assert score #y bs.ctx matches -37735..-37731
assert score #z bs.ctx matches -36894..-36890

data modify storage bs:in spline.evaluate_bezier set value {points:[[35.07, -64.012, 8.328], [-23.277, -80.464, -24.031], [-8.646, -30.478, -20.489], [0.607, 9.235, 30.675]],time:0.456}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches -6656..-6652
assert score #y bs.ctx matches -52349..-52345
assert score #z bs.ctx matches -12434..-12430

data modify storage bs:in spline.evaluate_bezier set value {points:[[-92.628, 38.556, -75.102], [-73.833, 15.066, -81.174], [59.332, -2.553, -51.87], [-13.502, 53.496, 79.353]],time:0.615}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_bezier[2] 1000
assert score #x bs.ctx matches -2701..-2697
assert score #y bs.ctx matches 17647..17651
assert score #z bs.ctx matches -30688..-30684
