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

data modify storage bs:in spline.sample_bspline set value {points:[[-87.424, -23.744], [22.32, -55.673], [53.55, -50.365], [-79.17, -33.548], [-90.698, -29.994], [-70.837, 43.153]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[0][1] 1000
assert score #x bs.ctx matches 9232..9236
assert score #y bs.ctx matches -49469..-49465
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[1][1] 1000
assert score #x bs.ctx matches 24178..24182
assert score #y bs.ctx matches -51700..-51696
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[2][1] 1000
assert score #x bs.ctx matches 32882..32886
assert score #y bs.ctx matches -52005..-52001
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[3][1] 1000
assert score #x bs.ctx matches 34008..34012
assert score #y bs.ctx matches -50788..-50784
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[4][1] 1000
assert score #x bs.ctx matches 26223..26227
assert score #y bs.ctx matches -48449..-48445
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[5][1] 1000
assert score #x bs.ctx matches 9156..9160
assert score #y bs.ctx matches -45388..-45384
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[6][1] 1000
assert score #x bs.ctx matches -13703..-13699
assert score #y bs.ctx matches -41995..-41991
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[7][1] 1000
assert score #x bs.ctx matches -37898..-37894
assert score #y bs.ctx matches -38657..-38653
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[8][1] 1000
assert score #x bs.ctx matches -58973..-58969
assert score #y bs.ctx matches -35760..-35756
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[9][1] 1000
assert score #x bs.ctx matches -73451..-73447
assert score #y bs.ctx matches -33413..-33409
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[10][1] 1000
assert score #x bs.ctx matches -81757..-81753
assert score #y bs.ctx matches -30599..-30595
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[11][1] 1000
assert score #x bs.ctx matches -85295..-85291
assert score #y bs.ctx matches -26026..-26022

data modify storage bs:in spline.sample_bspline set value {points:[[19.836, 13.735], [40.484, -34.911], [4.697, 7.609], [3.727, -75.611], [0.052, 75.466], [46.74, -90.519]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[0][1] 1000
assert score #x bs.ctx matches 31076..31080
assert score #y bs.ctx matches -19719..-19715
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[1][1] 1000
assert score #x bs.ctx matches 27658..27662
assert score #y bs.ctx matches -18200..-18196
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[2][1] 1000
assert score #x bs.ctx matches 22138..22142
assert score #y bs.ctx matches -14373..-14369
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[3][1] 1000
assert score #x bs.ctx matches 15943..15947
assert score #y bs.ctx matches -11627..-11623
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[4][1] 1000
assert score #x bs.ctx matches 10498..10502
assert score #y bs.ctx matches -13350..-13346
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[5][1] 1000
assert score #x bs.ctx matches 6894..6898
assert score #y bs.ctx matches -21429..-21425
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[6][1] 1000
assert score #x bs.ctx matches 4879..4883
assert score #y bs.ctx matches -31741..-31737
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[7][1] 1000
assert score #x bs.ctx matches 3868..3872
assert score #y bs.ctx matches -38661..-38657
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[8][1] 1000
assert score #x bs.ctx matches 3274..3278
assert score #y bs.ctx matches -36564..-36560
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[9][1] 1000
assert score #x bs.ctx matches 2747..2751
assert score #y bs.ctx matches -22195..-22191
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[10][1] 1000
assert score #x bs.ctx matches 2880..2884
assert score #y bs.ctx matches -1799..-1795
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[11][1] 1000
assert score #x bs.ctx matches 4503..4507
assert score #y bs.ctx matches 16011..16015

data modify storage bs:in spline.sample_bspline set value {points:[[49.505, 96.561], [76.715, 19.445], [-1.945, -22.567], [-42.151, -57.998], [57.444, -18.19], [20.495, -19.567]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[0][1] 1000
assert score #x bs.ctx matches 59068..59072
assert score #y bs.ctx matches 25294..25298
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[1][1] 1000
assert score #x bs.ctx matches 49704..49708
assert score #y bs.ctx matches 11425..11429
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[2][1] 1000
assert score #x bs.ctx matches 35979..35983
assert score #y bs.ctx matches -695..-691
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[3][1] 1000
assert score #x bs.ctx matches 20146..20150
assert score #y bs.ctx matches -11512..-11508
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[4][1] 1000
assert score #x bs.ctx matches 4462..4466
assert score #y bs.ctx matches -21472..-21468
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[5][1] 1000
assert score #x bs.ctx matches -8931..-8927
assert score #y bs.ctx matches -30768..-30764
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[6][1] 1000
assert score #x bs.ctx matches -18336..-18332
assert score #y bs.ctx matches -38580..-38576
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[7][1] 1000
assert score #x bs.ctx matches -22172..-22168
assert score #y bs.ctx matches -43835..-43831
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[8][1] 1000
assert score #x bs.ctx matches -18853..-18849
assert score #y bs.ctx matches -45460..-45456
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[9][1] 1000
assert score #x bs.ctx matches -7780..-7776
assert score #y bs.ctx matches -42865..-42861
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[10][1] 1000
assert score #x bs.ctx matches 7712..7716
assert score #y bs.ctx matches -37387..-37383
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[11][1] 1000
assert score #x bs.ctx matches 23307..23311
assert score #y bs.ctx matches -30844..-30840

data modify storage bs:in spline.sample_bspline set value {points:[[19.213, -29.911], [-8.093, -90.685], [73.042, 38.077], [30.536, 36.916], [61.515, 46.592], [78.875, 7.776]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[0][1] 1000
assert score #x bs.ctx matches 9978..9982
assert score #y bs.ctx matches -59098..-59094
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[1][1] 1000
assert score #x bs.ctx matches 19492..19496
assert score #y bs.ctx matches -45508..-45504
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[2][1] 1000
assert score #x bs.ctx matches 32156..32160
assert score #y bs.ctx matches -25064..-25060
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[3][1] 1000
assert score #x bs.ctx matches 44345..44349
assert score #y bs.ctx matches -2757..-2753
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[4][1] 1000
assert score #x bs.ctx matches 52433..52437
assert score #y bs.ctx matches 16421..16425
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[5][1] 1000
assert score #x bs.ctx matches 53911..53915
assert score #y bs.ctx matches 28678..28682
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[6][1] 1000
assert score #x bs.ctx matches 50742..50746
assert score #y bs.ctx matches 35014..35018
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[7][1] 1000
assert score #x bs.ctx matches 46005..46009
assert score #y bs.ctx matches 37628..37632
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[8][1] 1000
assert score #x bs.ctx matches 42781..42785
assert score #y bs.ctx matches 38720..38724
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[9][1] 1000
assert score #x bs.ctx matches 43410..43414
assert score #y bs.ctx matches 39969..39973
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[10][1] 1000
assert score #x bs.ctx matches 47271..47275
assert score #y bs.ctx matches 40968..40972
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bspline[11][1] 1000
assert score #x bs.ctx matches 53002..53006
assert score #y bs.ctx matches 40790..40794
