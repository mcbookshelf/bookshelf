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

data modify storage bs:in spline.stream_bspline set value {points:[[19.348], [14.196], [-14.35], [2.473], [39.071], [69.724]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches 10295..10299
await score #packtest.spline.bspline bs.ctx matches 5531..5535
await score #packtest.spline.bspline bs.ctx matches 379..383
await score #packtest.spline.bspline bs.ctx matches -4085..-4081
await score #packtest.spline.bspline bs.ctx matches -6790..-6786
await score #packtest.spline.bspline bs.ctx matches -6905..-6901
await score #packtest.spline.bspline bs.ctx matches -4583..-4579
await score #packtest.spline.bspline bs.ctx matches -226..-222
await score #packtest.spline.bspline bs.ctx matches 5767..5771
await score #packtest.spline.bspline bs.ctx matches 12995..12999
await score #packtest.spline.bspline bs.ctx matches 21058..21062
await score #packtest.spline.bspline bs.ctx matches 29553..29557

data modify storage bs:in spline.stream_bspline set value {points:[[11.216], [1.934], [60.532], [93.628], [-46.042], [71.443]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches 13245..13249
await score #packtest.spline.bspline bs.ctx matches 21288..21292
await score #packtest.spline.bspline bs.ctx matches 32114..32118
await score #packtest.spline.bspline bs.ctx matches 44264..44268
await score #packtest.spline.bspline bs.ctx matches 56280..56284
await score #packtest.spline.bspline bs.ctx matches 66561..66565
await score #packtest.spline.bspline bs.ctx matches 72947..72951
await score #packtest.spline.bspline bs.ctx matches 73138..73142
await score #packtest.spline.bspline bs.ctx matches 64832..64836
await score #packtest.spline.bspline bs.ctx matches 47231..47235
await score #packtest.spline.bspline bs.ctx matches 25549..25553
await score #packtest.spline.bspline bs.ctx matches 6505..6509

data modify storage bs:in spline.stream_bspline set value {points:[[80.311], [27.541], [-48.016], [1.532], [-83.298], [16.973]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches 23741..23745
await score #packtest.spline.bspline bs.ctx matches 7373..7377
await score #packtest.spline.bspline bs.ctx matches -8108..-8104
await score #packtest.spline.bspline bs.ctx matches -20392..-20388
await score #packtest.spline.bspline bs.ctx matches -27167..-27163
await score #packtest.spline.bspline bs.ctx matches -27184..-27180
await score #packtest.spline.bspline bs.ctx matches -23437..-23433
await score #packtest.spline.bspline bs.ctx matches -19980..-19976
await score #packtest.spline.bspline bs.ctx matches -20866..-20862
await score #packtest.spline.bspline bs.ctx matches -28644..-28640
await score #packtest.spline.bspline bs.ctx matches -39828..-39824
await score #packtest.spline.bspline bs.ctx matches -49428..-49424

data modify storage bs:in spline.stream_bspline set value {points:[[54.027], [14.284], [69.827], [52.096], [87.227], [83.562]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches 30163..30167
await score #packtest.spline.bspline bs.ctx matches 34677..34681
await score #packtest.spline.bspline bs.ctx matches 42512..42516
await score #packtest.spline.bspline bs.ctx matches 51035..51039
await score #packtest.spline.bspline bs.ctx matches 57613..57617
await score #packtest.spline.bspline bs.ctx matches 60378..60382
await score #packtest.spline.bspline bs.ctx matches 60534..60538
await score #packtest.spline.bspline bs.ctx matches 60053..60057
await score #packtest.spline.bspline bs.ctx matches 60904..60908
await score #packtest.spline.bspline bs.ctx matches 64493..64497
await score #packtest.spline.bspline bs.ctx matches 69953..69957
await score #packtest.spline.bspline bs.ctx matches 75852..75856
