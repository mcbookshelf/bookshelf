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

data modify storage bs:in spline.evaluate_hermite set value {points:[[-43.932, 72.139, -74.982], [-77.617, -33.806, -31.131], [40.541, -10.6, 47.612], [-56.689, 27.846, 63.36]],time:0.335}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -19580..-19576
assert score #y bs.ctx matches 31938..31942
assert score #z bs.ctx matches -37607..-37603

data modify storage bs:in spline.evaluate_hermite set value {points:[[-7.08, 39.521, 78.623], [88.289, -71.32, -67.473], [-3.736, -94.827, 63.278], [52.453, 15.963, 42.156]],time:0.541}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -1883..-1879
assert score #y bs.ctx matches -63416..-63412
assert score #z bs.ctx matches 56193..56197

data modify storage bs:in spline.evaluate_hermite set value {points:[[-95.867, 99.343, 50.901], [-65.046, 78.179, 56.082], [60.638, 86.245, -80.605], [53.162, 10.496, 86.664]],time:0.491}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -14891..-14887
assert score #y bs.ctx matches 99572..99576
assert score #z bs.ctx matches -32945..-32941

data modify storage bs:in spline.evaluate_hermite set value {points:[[-77.112, 5.973, 69.236], [-55.824, 51.12, -90.78], [98.377, -43.206, 50.107], [-86.718, 59.277, -22.569]],time:0.347}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -10684..-10680
assert score #y bs.ctx matches -9062..-9058
assert score #z bs.ctx matches 45960..45964

data modify storage bs:in spline.evaluate_hermite set value {points:[[32.673, -46.848, 94.262], [-10.238, -89.424, 28.131], [18.667, -98.166, -72.672], [-86.244, 75.308, 64.244]],time:0.928}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches 25171..25175
assert score #y bs.ctx matches -108369..-108365
assert score #z bs.ctx matches -79010..-79006

data modify storage bs:in spline.evaluate_hermite set value {points:[[-51.789, 56.13, 8.463], [87.193, -14.746, 84.577], [-61.704, -82.943, -96.216], [-58.203, 9.125, 17.803]],time:0.595}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -45082..-45078
assert score #y bs.ctx matches -53106..-53102
assert score #z bs.ctx matches -67535..-67531

data modify storage bs:in spline.evaluate_hermite set value {points:[[4.016, -92.132, 89.9], [84.573, -12.81, -82.204], [-87.824, 88.474, -18.293], [80.09, 68.175, 30.907]],time:0.214}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches -2197..-2193
assert score #y bs.ctx matches -59643..-59639
assert score #z bs.ctx matches 52630..52634

data modify storage bs:in spline.evaluate_hermite set value {points:[[67.941, -85.392, 31.145], [-13.543, -98.592, -38.838], [-59.351, 15.245, -95.393], [40.671, 58.543, 66.27]],time:0.292}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_hermite[2] 1000
assert score #x bs.ctx matches 23752..23756
assert score #y bs.ctx matches -69209..-69205
assert score #z bs.ctx matches -14926..-14922
