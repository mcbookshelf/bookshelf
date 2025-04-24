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

data modify storage bs:in spline.sample_hermite set value {points:[[-44.473, 30.931], [-24.736, -64.889], [-55.897, -91.783], [54.103, 96.382], [85.813, -48.404], [1.632, -75.546], [15.701, 49.709], [11.512, 80.437]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[0][1] 1000
assert score #x bs.ctx matches -44475..-44471
assert score #y bs.ctx matches 30929..30933
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[1][1] 1000
assert score #x bs.ctx matches -48641..-48637
assert score #y bs.ctx matches -10540..-10536
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[2][1] 1000
assert score #x bs.ctx matches -61470..-61466
assert score #y bs.ctx matches -65926..-65922
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[3][1] 1000
assert score #x bs.ctx matches -68658..-68654
assert score #y bs.ctx matches -103563..-103559
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[4][1] 1000
assert score #x bs.ctx matches -55899..-55895
assert score #y bs.ctx matches -91785..-91781
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[5][1] 1000
assert score #x bs.ctx matches -14342..-14338
assert score #y bs.ctx matches -57274..-57270
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[6][1] 1000
assert score #x bs.ctx matches 39229..39233
assert score #y bs.ctx matches -43182..-43178
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[7][1] 1000
assert score #x bs.ctx matches 80663..80667
assert score #y bs.ctx matches -42547..-42543
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[8][1] 1000
assert score #x bs.ctx matches 85811..85815
assert score #y bs.ctx matches -48406..-48402
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[9][1] 1000
assert score #x bs.ctx matches 63214..63218
assert score #y bs.ctx matches -38333..-38329
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[10][1] 1000
assert score #x bs.ctx matches 40756..40760
assert score #y bs.ctx matches -6583..-6579
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[11][1] 1000
assert score #x bs.ctx matches 23297..23301
assert score #y bs.ctx matches 28783..28787

data modify storage bs:in spline.sample_hermite set value {points:[[1.13, 83.926], [-72.7, -24.102], [43.599, 63.22], [-50.133, 41.113], [55.251, -45.043], [-23.4, -43.205], [-21.342, 12.283], [-38.339, 52.297]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[0][1] 1000
assert score #x bs.ctx matches 1128..1132
assert score #y bs.ctx matches 83924..83928
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[1][1] 1000
assert score #x bs.ctx matches 1775..1779
assert score #y bs.ctx matches 66534..66538
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[2][1] 1000
assert score #x bs.ctx matches 24850..24854
assert score #y bs.ctx matches 62831..62835
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[3][1] 1000
assert score #x bs.ctx matches 46681..46685
assert score #y bs.ctx matches 64498..64502
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[4][1] 1000
assert score #x bs.ctx matches 43597..43601
assert score #y bs.ctx matches 63218..63222
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[5][1] 1000
assert score #x bs.ctx matches 35923..35927
assert score #y bs.ctx matches 43107..43111
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[6][1] 1000
assert score #x bs.ctx matches 47538..47542
assert score #y bs.ctx matches 6093..6097
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[7][1] 1000
assert score #x bs.ctx matches 60095..60099
assert score #y bs.ctx matches -29424..-29420
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[8][1] 1000
assert score #x bs.ctx matches 55249..55253
assert score #y bs.ctx matches -45045..-45041
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[9][1] 1000
assert score #x bs.ctx matches 33018..33022
assert score #y bs.ctx matches -37705..-37701
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[10][1] 1000
assert score #x bs.ctx matches 9246..9250
assert score #y bs.ctx matches -21154..-21150
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[11][1] 1000
assert score #x bs.ctx matches -10673..-10669
assert score #y bs.ctx matches -2217..-2213

data modify storage bs:in spline.sample_hermite set value {points:[[73.338, 86.065], [-60.156, 41.997], [-37.66, 13.294], [79.89, 51.796], [16.272, 46.72], [91.285, -87.879], [65.432, -75.614], [92.079, -32.071]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[0][1] 1000
assert score #x bs.ctx matches 73336..73340
assert score #y bs.ctx matches 86063..86067
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[1][1] 1000
assert score #x bs.ctx matches 31710..31714
assert score #y bs.ctx matches 66691..66695
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[2][1] 1000
assert score #x bs.ctx matches -13543..-13539
assert score #y bs.ctx matches 39356..39360
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[3][1] 1000
assert score #x bs.ctx matches -43107..-43103
assert score #y bs.ctx matches 17182..17186
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[4][1] 1000
assert score #x bs.ctx matches -37662..-37658
assert score #y bs.ctx matches 13292..13296
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[5][1] 1000
assert score #x bs.ctx matches -16221..-16217
assert score #y bs.ctx matches 30238..30242
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[6][1] 1000
assert score #x bs.ctx matches -5379..-5375
assert score #y bs.ctx matches 51643..51647
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[7][1] 1000
assert score #x bs.ctx matches 2805..2809
assert score #y bs.ctx matches 62228..62232
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[8][1] 1000
assert score #x bs.ctx matches 16269..16273
assert score #y bs.ctx matches 46718..46722
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[9][1] 1000
assert score #x bs.ctx matches 33251..33255
assert score #y bs.ctx matches 6634..6638
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[10][1] 1000
assert score #x bs.ctx matches 46896..46900
assert score #y bs.ctx matches -36717..-36713
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[11][1] 1000
assert score #x bs.ctx matches 57518..57522
assert score #y bs.ctx matches -68934..-68930

data modify storage bs:in spline.sample_hermite set value {points:[[9.151, -41.306], [-33.778, -15.11], [51.777, -32.543], [2.366, 45.125], [93.246, -74.537], [-3.944, -35.802], [17.472, -99.919], [-92.82, -97.843]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[0][1] 1000
assert score #x bs.ctx matches 9149..9153
assert score #y bs.ctx matches -41308..-41304
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[1][1] 1000
assert score #x bs.ctx matches 12089..12093
assert score #y bs.ctx matches -39896..-39892
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[2][1] 1000
assert score #x bs.ctx matches 31272..31276
assert score #y bs.ctx matches -43360..-43356
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[3][1] 1000
assert score #x bs.ctx matches 50051..50055
assert score #y bs.ctx matches -43608..-43604
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[4][1] 1000
assert score #x bs.ctx matches 51775..51779
assert score #y bs.ctx matches -32545..-32541
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[5][1] 1000
assert score #x bs.ctx matches 55862..55866
assert score #y bs.ctx matches -30000..-29996
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[6][1] 1000
assert score #x bs.ctx matches 78482..78486
assert score #y bs.ctx matches -48675..-48671
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[7][1] 1000
assert score #x bs.ctx matches 98116..98120
assert score #y bs.ctx matches -69784..-69780
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[8][1] 1000
assert score #x bs.ctx matches 93244..93248
assert score #y bs.ctx matches -74539..-74535
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[9][1] 1000
assert score #x bs.ctx matches 72907..72911
assert score #y bs.ctx matches -73155..-73151
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[10][1] 1000
assert score #x bs.ctx matches 56995..56999
assert score #y bs.ctx matches -82648..-82644
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_hermite[11][1] 1000
assert score #x bs.ctx matches 40264..40268
assert score #y bs.ctx matches -94431..-94427
