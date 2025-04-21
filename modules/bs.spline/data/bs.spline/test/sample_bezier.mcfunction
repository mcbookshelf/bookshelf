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

data modify storage bs:in spline.sample_bezier set value {points:[[-14.461, -13.174], [-54.593, 30.276], [86.602, -29.258], [57.294, 67.12], [81.546, 97.52], [18.985, 7.416], [9.561, -57.309], [-70.111, 59.96], [-16.667, 85.548], [86.335, 95.975]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[0][1] 1000
assert score #x bs.ctx matches -14463..-14459
assert score #y bs.ctx matches -13176..-13172
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[1][1] 1000
assert score #x bs.ctx matches -16061..-16057
assert score #y bs.ctx matches 4147..4151
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[2][1] 1000
assert score #x bs.ctx matches 17356..17360
assert score #y bs.ctx matches 7123..7127
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[3][1] 1000
assert score #x bs.ctx matches 52801..52805
assert score #y bs.ctx matches 20023..20027
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[4][1] 1000
assert score #x bs.ctx matches 57292..57296
assert score #y bs.ctx matches 67118..67122
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[5][1] 1000
assert score #x bs.ctx matches 61390..61394
assert score #y bs.ctx matches 69603..69607
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[6][1] 1000
assert score #x bs.ctx matches 46054..46058
assert score #y bs.ctx matches 40575..40579
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[7][1] 1000
assert score #x bs.ctx matches 24403..24407
assert score #y bs.ctx matches -6288..-6284
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[8][1] 1000
assert score #x bs.ctx matches 9559..9563
assert score #y bs.ctx matches -57311..-57307
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[9][1] 1000
assert score #x bs.ctx matches -26541..-26537
assert score #y bs.ctx matches 14646..14650
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[10][1] 1000
assert score #x bs.ctx matches -20557..-20553
assert score #y bs.ctx matches 59397..59401
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[11][1] 1000
assert score #x bs.ctx matches 19679..19683
assert score #y bs.ctx matches 84114..84118

data modify storage bs:in spline.sample_bezier set value {points:[[85.26, 43.269], [-56.108, 10.696], [-84.852, 82.375], [-44.238, 87.916], [-73.061, -86.326], [74.124, -4.274], [32.715, 72.958], [40.028, 14.346], [76.055, 18.302], [44.693, 7.995]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[0][1] 1000
assert score #x bs.ctx matches 85258..85262
assert score #y bs.ctx matches 43267..43271
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[1][1] 1000
assert score #x bs.ctx matches -327..-323
assert score #y bs.ctx matches 35722..35726
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[2][1] 1000
assert score #x bs.ctx matches -47734..-47730
assert score #y bs.ctx matches 51298..51302
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[3][1] 1000
assert score #x bs.ctx matches -61020..-61016
assert score #y bs.ctx matches 74020..74024
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[4][1] 1000
assert score #x bs.ctx matches -44240..-44236
assert score #y bs.ctx matches 87914..87918
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[5][1] 1000
assert score #x bs.ctx matches -38553..-38549
assert score #y bs.ctx matches 1208..1212
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[6][1] 1000
assert score #x bs.ctx matches -1044..-1040
assert score #y bs.ctx matches -13868..-13864
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[7][1] 1000
assert score #x bs.ctx matches 34105..34109
assert score #y bs.ctx matches 18208..18212
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[8][1] 1000
assert score #x bs.ctx matches 32713..32717
assert score #y bs.ctx matches 72956..72960
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[9][1] 1000
assert score #x bs.ctx matches 42080..42084
assert score #y bs.ctx matches 39528..39532
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[10][1] 1000
assert score #x bs.ctx matches 53205..53209
assert score #y bs.ctx matches 22360..22364
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[11][1] 1000
assert score #x bs.ctx matches 57079..57083
assert score #y bs.ctx matches 14249..14253

data modify storage bs:in spline.sample_bezier set value {points:[[14.279, -33.1], [-74.07, -21.125], [84.903, 91.224], [4.186, -68.547], [-66.224, -50.71], [-1.82, 45.481], [40.532, 77.892], [94.738, -20.052], [96.879, -69.256], [-30.159, 92.736]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[0][1] 1000
assert score #x bs.ctx matches 14277..14281
assert score #y bs.ctx matches -33102..-33098
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[1][1] 1000
assert score #x bs.ctx matches -13221..-13217
assert score #y bs.ctx matches -11121..-11117
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[2][1] 1000
assert score #x bs.ctx matches 6369..6373
assert score #y bs.ctx matches 13579..13583
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[3][1] 1000
assert score #x bs.ctx matches 27389..27393
assert score #y bs.ctx matches 6077..6081
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[4][1] 1000
assert score #x bs.ctx matches 4184..4188
assert score #y bs.ctx matches -68549..-68545
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[5][1] 1000
assert score #x bs.ctx matches -25797..-25793
assert score #y bs.ctx matches -42701..-42697
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[6][1] 1000
assert score #x bs.ctx matches -19929..-19925
assert score #y bs.ctx matches -795..-791
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[7][1] 1000
assert score #x bs.ctx matches 7082..7086
assert score #y bs.ctx matches 43844..43848
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[8][1] 1000
assert score #x bs.ctx matches 40530..40534
assert score #y bs.ctx matches 77890..77894
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[9][1] 1000
assert score #x bs.ctx matches 70217..70221
assert score #y bs.ctx matches 16109..16113
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[10][1] 1000
assert score #x bs.ctx matches 73151..73155
assert score #y bs.ctx matches -12164..-12160
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[11][1] 1000
assert score #x bs.ctx matches 42101..42105
assert score #y bs.ctx matches 8301..8305

data modify storage bs:in spline.sample_bezier set value {points:[[-78.922, -80.188], [-6.821, 15.086], [14.364, -69.504], [17.975, -21.135], [16.262, 39.52], [33.381, 69.728], [40.421, 25.858], [-92.911, -89.658], [31.857, -5.516], [-76.25, 42.618]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[0][1] 1000
assert score #x bs.ctx matches -78924..-78920
assert score #y bs.ctx matches -80190..-80186
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[1][1] 1000
assert score #x bs.ctx matches -33874..-33870
assert score #y bs.ctx matches -37571..-37567
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[2][1] 1000
assert score #x bs.ctx matches -4792..-4788
assert score #y bs.ctx matches -33074..-33070
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[3][1] 1000
assert score #x bs.ctx matches 11449..11453
assert score #y bs.ctx matches -37372..-37368
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[4][1] 1000
assert score #x bs.ctx matches 17973..17977
assert score #y bs.ctx matches -21137..-21133
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[5][1] 1000
assert score #x bs.ctx matches 19768..19772
assert score #y bs.ctx matches 17964..17968
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[6][1] 1000
assert score #x bs.ctx matches 25914..25918
assert score #y bs.ctx matches 41556..41560
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[7][1] 1000
assert score #x bs.ctx matches 33701..33705
assert score #y bs.ctx matches 45551..45555
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[8][1] 1000
assert score #x bs.ctx matches 40419..40423
assert score #y bs.ctx matches 25856..25860
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[9][1] 1000
assert score #x bs.ctx matches -18858..-18854
assert score #y bs.ctx matches -27027..-27023
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[10][1] 1000
assert score #x bs.ctx matches -27376..-27372
assert score #y bs.ctx matches -27133..-27129
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.sample_bezier[11][1] 1000
assert score #x bs.ctx matches -31164..-31160
assert score #y bs.ctx matches 3446..3450
