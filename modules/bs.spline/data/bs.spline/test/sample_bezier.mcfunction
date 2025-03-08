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

data modify storage bs:in spline.sample_bezier set value {points:[[-21.339072190371027], [-97.06040800487806], [-61.65486923398837], [46.66220777276564], [31.369546321721202], [-30.32512264829954], [29.90953917886219], [13.076012337113994], [61.01235353942215], [36.15957488053792]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
assert score #x bs.ctx matches -21340..-21338
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
assert score #x bs.ctx matches -57892..-57890
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
assert score #x bs.ctx matches -56354..-56352
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
assert score #x bs.ctx matches -20309..-20307
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
assert score #x bs.ctx matches 46661..46663
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
assert score #x bs.ctx matches 29122..29124
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
assert score #x bs.ctx matches 9962..9964
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
assert score #x bs.ctx matches 4964..4966
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
assert score #x bs.ctx matches 29909..29911
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
assert score #x bs.ctx matches 27278..27280
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
assert score #x bs.ctx matches 36041..36043
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
assert score #x bs.ctx matches 43300..43302

data modify storage bs:in spline.sample_bezier set value {points:[[-12.276530499968416], [14.905040071308349], [-29.93093507840979], [80.51185664257767], [-64.21691595696235], [30.664866490339193], [-53.08187576758212], [6.194557842037568], [13.431904629178646], [58.19264206346466]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
assert score #x bs.ctx matches -12278..-12276
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
assert score #x bs.ctx matches -1843..-1841
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
assert score #x bs.ctx matches 2894..2896
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
assert score #x bs.ctx matches 23242..23244
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
assert score #x bs.ctx matches 80511..80513
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
assert score #x bs.ctx matches 10356..10358
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
assert score #x bs.ctx matches -9154..-9152
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
assert score #x bs.ctx matches -17231..-17229
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
assert score #x bs.ctx matches -53083..-53081
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
assert score #x bs.ctx matches -16983..-16981
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
assert score #x bs.ctx matches 7998..8000
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
assert score #x bs.ctx matches 30257..30259

data modify storage bs:in spline.sample_bezier set value {points:[[-46.72666945951358], [-46.47225809670452], [-48.526768291137046], [-24.492908604807553], [-1.1107477085473079], [28.362694692459286], [79.00271556004122], [-45.28487399439638], [57.45774748646065], [68.40947362989135]],step:.25}
function #bs.spline:sample_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[0][0] 1000
assert score #x bs.ctx matches -46728..-46726
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[1][0] 1000
assert score #x bs.ctx matches -46526..-46524
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[2][0] 1000
assert score #x bs.ctx matches -44528..-44526
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[3][0] 1000
assert score #x bs.ctx matches -38071..-38069
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[4][0] 1000
assert score #x bs.ctx matches -24494..-24492
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[5][0] 1000
assert score #x bs.ctx matches -5580..-5578
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[6][0] 1000
assert score #x bs.ctx matches 17032..17034
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[7][0] 1000
assert score #x bs.ctx matches 44755..44757
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[8][0] 1000
assert score #x bs.ctx matches 79002..79004
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[9][0] 1000
assert score #x bs.ctx matches 23373..23375
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[10][0] 1000
assert score #x bs.ctx matches 22990..22992
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bezier[11][0] 1000
assert score #x bs.ctx matches 47965..47967
