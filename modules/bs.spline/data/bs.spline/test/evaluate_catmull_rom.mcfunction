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

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[40.842, -94.954, 31.255], [12.726, -97.866, -61.634], [-82.453, 69.819, -72.012], [-85.526, -74.261, 76.326]],time:0.981}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches -81477..-81473
assert score #y bs.ctx matches 69451..69455
assert score #z bs.ctx matches -73282..-73278

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-13.602, 66.539, 87.155], [-28.059, -77.389, 57.82], [36.853, 64.862, 89.982], [98.278, 21.582, -19.276]],time:0.781}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches 21382..21386
assert score #y bs.ctx matches 40739..40743
assert score #z bs.ctx matches 91230..91234

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[67.599, 87.481, -8.718], [20.812, 99.513, -50.047], [46.731, -15.427, -44.752], [93.626, 15.165, 40.286]],time:0.667}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches 33855..33859
assert score #y bs.ctx matches 16761..16765
assert score #z bs.ctx matches -54148..-54144

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-42.493, -62.521, 8.709], [58.813, -98.082, -62.318], [-65.474, -66.501, 3.147], [94.432, -0.708, -18.436]],time:0.764}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches -50919..-50915
assert score #y bs.ctx matches -77741..-77737
assert score #z bs.ctx matches -9213..-9209

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[46.746, 33.295, 59.625], [9.332, -47.819, 5.438], [-25.949, 4.387, 88.22], [25.999, 29.882, 38.331]],time:0.898}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches -25950..-25946
assert score #y bs.ctx matches -464..-460
assert score #z bs.ctx matches 84591..84595

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[41.619, -9.677, 56.409], [-13.354, 62.929, -84.185], [65.062, 44.567, -84.42], [14.774, 36.593, 22.835]],time:0.841}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches 58411..58415
assert score #y bs.ctx matches 47868..47872
assert score #z bs.ctx matches -91921..-91917

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-83.728, 65.599, -43.017], [-76.209, 36.15, -70.948], [46.388, 29.511, 29.166], [83.112, -11.276, -8.545]],time:0.356}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches -37557..-37553
assert score #y bs.ctx matches 33494..33498
assert score #z bs.ctx matches -39138..-39134

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-50.182, -28.152, 13.084], [62.514, 9.414, -79.852], [-15.132, 73.563, 86.547], [-23.419, -1.76, 27.639]],time:0.123}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
execute store result score #z bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[2] 1000
assert score #x bs.ctx matches 61505..61509
assert score #y bs.ctx matches 16970..16974
assert score #z bs.ctx matches -70159..-70155
