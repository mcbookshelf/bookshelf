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

data modify storage bs:in spline.sample_linear set value {points:[[-20.703, -91.215], [-40.79, 39.149], [-98.795, -1.819], [79.645, 99.66], [-58.935, 14.929], [-96.406, 49.072]],step:.25}
function #bs.spline:sample_linear
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[0][1] 1000
assert score #x bs.ctx matches -20705..-20701
assert score #y bs.ctx matches -91217..-91213
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[1][1] 1000
assert score #x bs.ctx matches -25727..-25723
assert score #y bs.ctx matches -58626..-58622
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[2][1] 1000
assert score #x bs.ctx matches -30748..-30744
assert score #y bs.ctx matches -26035..-26031
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[3][1] 1000
assert score #x bs.ctx matches -35770..-35766
assert score #y bs.ctx matches 6556..6560
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[4][1] 1000
assert score #x bs.ctx matches -40792..-40788
assert score #y bs.ctx matches 39147..39151
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[5][1] 1000
assert score #x bs.ctx matches -55293..-55289
assert score #y bs.ctx matches 28905..28909
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[6][1] 1000
assert score #x bs.ctx matches -69795..-69791
assert score #y bs.ctx matches 18663..18667
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[7][1] 1000
assert score #x bs.ctx matches -84296..-84292
assert score #y bs.ctx matches 8421..8425
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[8][1] 1000
assert score #x bs.ctx matches -98797..-98793
assert score #y bs.ctx matches -1821..-1817
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[9][1] 1000
assert score #x bs.ctx matches -54187..-54183
assert score #y bs.ctx matches 23549..23553
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[10][1] 1000
assert score #x bs.ctx matches -9577..-9573
assert score #y bs.ctx matches 48918..48922
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[11][1] 1000
assert score #x bs.ctx matches 35033..35037
assert score #y bs.ctx matches 74288..74292

data modify storage bs:in spline.sample_linear set value {points:[[32.583, 43.741], [52.832, -27.932], [58.595, -61.35], [38.229, -18.474], [53.707, 29.533], [74.161, 38.678]],step:.25}
function #bs.spline:sample_linear
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[0][1] 1000
assert score #x bs.ctx matches 32581..32585
assert score #y bs.ctx matches 43739..43743
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[1][1] 1000
assert score #x bs.ctx matches 37643..37647
assert score #y bs.ctx matches 25821..25825
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[2][1] 1000
assert score #x bs.ctx matches 42705..42709
assert score #y bs.ctx matches 7903..7907
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[3][1] 1000
assert score #x bs.ctx matches 47768..47772
assert score #y bs.ctx matches -10016..-10012
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[4][1] 1000
assert score #x bs.ctx matches 52830..52834
assert score #y bs.ctx matches -27934..-27930
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[5][1] 1000
assert score #x bs.ctx matches 54271..54275
assert score #y bs.ctx matches -36288..-36284
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[6][1] 1000
assert score #x bs.ctx matches 55711..55715
assert score #y bs.ctx matches -44643..-44639
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[7][1] 1000
assert score #x bs.ctx matches 57152..57156
assert score #y bs.ctx matches -52997..-52993
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[8][1] 1000
assert score #x bs.ctx matches 58593..58597
assert score #y bs.ctx matches -61352..-61348
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[9][1] 1000
assert score #x bs.ctx matches 53502..53506
assert score #y bs.ctx matches -50633..-50629
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[10][1] 1000
assert score #x bs.ctx matches 48410..48414
assert score #y bs.ctx matches -39914..-39910
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[11][1] 1000
assert score #x bs.ctx matches 43318..43322
assert score #y bs.ctx matches -29195..-29191

data modify storage bs:in spline.sample_linear set value {points:[[-70.04, -20.427], [76.424, 90.853], [21.805, -94.0], [-72.353, -82.029], [-42.101, -12.821], [-47.571, 99.002]],step:.25}
function #bs.spline:sample_linear
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[0][1] 1000
assert score #x bs.ctx matches -70042..-70038
assert score #y bs.ctx matches -20429..-20425
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[1][1] 1000
assert score #x bs.ctx matches -33426..-33422
assert score #y bs.ctx matches 7391..7395
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[2][1] 1000
assert score #x bs.ctx matches 3190..3194
assert score #y bs.ctx matches 35211..35215
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[3][1] 1000
assert score #x bs.ctx matches 39806..39810
assert score #y bs.ctx matches 63031..63035
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[4][1] 1000
assert score #x bs.ctx matches 76422..76426
assert score #y bs.ctx matches 90851..90855
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[5][1] 1000
assert score #x bs.ctx matches 62767..62771
assert score #y bs.ctx matches 44638..44642
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[6][1] 1000
assert score #x bs.ctx matches 49113..49117
assert score #y bs.ctx matches -1576..-1572
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[7][1] 1000
assert score #x bs.ctx matches 35458..35462
assert score #y bs.ctx matches -47789..-47785
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[8][1] 1000
assert score #x bs.ctx matches 21803..21807
assert score #y bs.ctx matches -94002..-93998
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[9][1] 1000
assert score #x bs.ctx matches -1737..-1733
assert score #y bs.ctx matches -91009..-91005
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[10][1] 1000
assert score #x bs.ctx matches -25276..-25272
assert score #y bs.ctx matches -88016..-88012
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[11][1] 1000
assert score #x bs.ctx matches -48815..-48811
assert score #y bs.ctx matches -85024..-85020

data modify storage bs:in spline.sample_linear set value {points:[[51.069, 87.558], [59.058, 50.079], [22.561, -34.019], [-86.042, -70.912], [8.413, -31.279], [24.203, 41.355]],step:.25}
function #bs.spline:sample_linear
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[0][1] 1000
assert score #x bs.ctx matches 51067..51071
assert score #y bs.ctx matches 87556..87560
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[1][1] 1000
assert score #x bs.ctx matches 53064..53068
assert score #y bs.ctx matches 78186..78190
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[2][1] 1000
assert score #x bs.ctx matches 55062..55066
assert score #y bs.ctx matches 68817..68821
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[3][1] 1000
assert score #x bs.ctx matches 57059..57063
assert score #y bs.ctx matches 59447..59451
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[4][1] 1000
assert score #x bs.ctx matches 59056..59060
assert score #y bs.ctx matches 50077..50081
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[5][1] 1000
assert score #x bs.ctx matches 49932..49936
assert score #y bs.ctx matches 29052..29056
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[6][1] 1000
assert score #x bs.ctx matches 40807..40811
assert score #y bs.ctx matches 8027..8031
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[7][1] 1000
assert score #x bs.ctx matches 31683..31687
assert score #y bs.ctx matches -12996..-12992
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[8][1] 1000
assert score #x bs.ctx matches 22559..22563
assert score #y bs.ctx matches -34021..-34017
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[9][1] 1000
assert score #x bs.ctx matches -4592..-4588
assert score #y bs.ctx matches -43244..-43240
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[10][1] 1000
assert score #x bs.ctx matches -31743..-31739
assert score #y bs.ctx matches -52468..-52464
execute store result score #x bs.ctx run data get storage bs:out spline.sample_linear[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_linear[11][1] 1000
assert score #x bs.ctx matches -58893..-58889
assert score #y bs.ctx matches -61691..-61687
