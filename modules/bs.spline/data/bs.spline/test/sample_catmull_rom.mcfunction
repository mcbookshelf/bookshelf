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

data modify storage bs:in spline.sample_catmull_rom set value {points:[[28.252, 39.112], [69.669, -39.269], [-69.043, -72.749], [96.654, 54.11], [-75.561, -27.302], [-54.375, 26.465]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][1] 1000
assert score #x bs.ctx matches 69667..69671
assert score #y bs.ctx matches -39271..-39267
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][1] 1000
assert score #x bs.ctx matches 40520..40524
assert score #y bs.ctx matches -54556..-54552
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][1] 1000
assert score #x bs.ctx matches -7457..-7453
assert score #y bs.ctx matches -68839..-68835
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][1] 1000
assert score #x bs.ctx matches -51549..-51545
assert score #y bs.ctx matches -76707..-76703
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][1] 1000
assert score #x bs.ctx matches -69045..-69041
assert score #y bs.ctx matches -72751..-72747
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][1] 1000
assert score #x bs.ctx matches -41105..-41101
assert score #y bs.ctx matches -47429..-47425
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][1] 1000
assert score #x bs.ctx matches 15897..15901
assert score #y bs.ctx matches -6326..-6322
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][1] 1000
assert score #x bs.ctx matches 71853..71857
assert score #y bs.ctx matches 33279..33283
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][1] 1000
assert score #x bs.ctx matches 96652..96656
assert score #y bs.ctx matches 54108..54112
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][1] 1000
assert score #x bs.ctx matches 72825..72829
assert score #y bs.ctx matches 45231..45235
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][1] 1000
assert score #x bs.ctx matches 19576..19580
assert score #y bs.ctx matches 17970..17974
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][1] 1000
assert score #x bs.ctx matches -38188..-38184
assert score #y bs.ctx matches -11574..-11570

data modify storage bs:in spline.sample_catmull_rom set value {points:[[-52.574, 63.379], [-74.566, -1.011], [-90.112, -5.845], [-80.108, -27.195], [45.974, 68.397], [-54.322, 56.472]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][1] 1000
assert score #x bs.ctx matches -74568..-74564
assert score #y bs.ctx matches -1012..-1008
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][1] 1000
assert score #x bs.ctx matches -79507..-79503
assert score #y bs.ctx matches -6022..-6018
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][1] 1000
assert score #x bs.ctx matches -84341..-84337
assert score #y bs.ctx matches -6120..-6116
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][1] 1000
assert score #x bs.ctx matches -88175..-88171
assert score #y bs.ctx matches -4873..-4869
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][1] 1000
assert score #x bs.ctx matches -90114..-90110
assert score #y bs.ctx matches -5847..-5843
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][1] 1000
assert score #x bs.ctx matches -92130..-92126
assert score #y bs.ctx matches -12764..-12760
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][1] 1000
assert score #x bs.ctx matches -93964..-93960
assert score #y bs.ctx matches -22799..-22795
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][1] 1000
assert score #x bs.ctx matches -91372..-91368
assert score #y bs.ctx matches -29695..-29691
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][1] 1000
assert score #x bs.ctx matches -80110..-80106
assert score #y bs.ctx matches -27197..-27193
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][1] 1000
assert score #x bs.ctx matches -51446..-51442
assert score #y bs.ctx matches -9002..-8998
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][1] 1000
assert score #x bs.ctx matches -10175..-10171
assert score #y bs.ctx matches 20010..20014
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][1] 1000
assert score #x bs.ctx matches 27648..27652
assert score #y bs.ctx matches 49316..49320

data modify storage bs:in spline.sample_catmull_rom set value {points:[[93.697, 71.881], [-28.393, -69.96], [22.631, -34.923], [-76.37, -1.071], [-45.94, 81.636], [91.931, -47.389]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][1] 1000
assert score #x bs.ctx matches -28395..-28391
assert score #y bs.ctx matches -69962..-69958
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][1] 1000
assert score #x bs.ctx matches -24295..-24291
assert score #y bs.ctx matches -73612..-73608
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][1] 1000
assert score #x bs.ctx matches -4326..-4322
assert score #y bs.ctx matches -63424..-63420
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][1] 1000
assert score #x bs.ctx matches 16364..16368
assert score #y bs.ctx matches -47747..-47743
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][1] 1000
assert score #x bs.ctx matches 22629..22633
assert score #y bs.ctx matches -34925..-34921
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][1] 1000
assert score #x bs.ctx matches 5394..5398
assert score #y bs.ctx matches -27524..-27520
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][1] 1000
assert score #x bs.ctx matches -25584..-25580
assert score #y bs.ctx matches -20978..-20974
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][1] 1000
assert score #x bs.ctx matches -57206..-57202
assert score #y bs.ctx matches -12943..-12939
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][1] 1000
assert score #x bs.ctx matches -76372..-76368
assert score #y bs.ctx matches -1073..-1069
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][1] 1000
assert score #x bs.ctx matches -80383..-80379
assert score #y bs.ctx matches 21131..21135
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][1] 1000
assert score #x bs.ctx matches -75962..-75958
assert score #y bs.ctx matches 50460..50464
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][1] 1000
assert score #x bs.ctx matches -64137..-64133
assert score #y bs.ctx matches 74700..74704

data modify storage bs:in spline.sample_catmull_rom set value {points:[[-34.374, 62.225], [26.113, 7.634], [-4.569, -32.73], [-23.737, -94.98], [-98.451, 38.492], [76.454, 66.023]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][1] 1000
assert score #x bs.ctx matches 26111..26115
assert score #y bs.ctx matches 7632..7636
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][1] 1000
assert score #x bs.ctx matches 24581..24585
assert score #y bs.ctx matches -2946..-2942
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][1] 1000
assert score #x bs.ctx matches 15748..15752
assert score #y bs.ctx matches -12071..-12067
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][1] 1000
assert score #x bs.ctx matches 4427..4431
assert score #y bs.ctx matches -21436..-21432
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][1] 1000
assert score #x bs.ctx matches -4571..-4567
assert score #y bs.ctx matches -32731..-32727
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][1] 1000
assert score #x bs.ctx matches -8871..-8867
assert score #y bs.ctx matches -51343..-51339
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][1] 1000
assert score #x bs.ctx matches -11403..-11399
assert score #y bs.ctx matches -74722..-74718
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][1] 1000
assert score #x bs.ctx matches -15311..-15307
assert score #y bs.ctx matches -92668..-92664
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][1] 1000
assert score #x bs.ctx matches -23739..-23735
assert score #y bs.ctx matches -94982..-94978
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][1] 1000
assert score #x bs.ctx matches -44362..-44358
assert score #y bs.ctx matches -72893..-72889
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][1] 1000
assert score #x bs.ctx matches -73226..-73222
assert score #y bs.ctx matches -33857..-33853
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][1] 1000
assert score #x bs.ctx matches -96024..-96020
assert score #y bs.ctx matches 7984..7988
