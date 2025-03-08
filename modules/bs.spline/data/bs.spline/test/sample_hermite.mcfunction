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

data modify storage bs:in spline.sample_hermite set value {points:[[-87.82987466575365], [-24.897666248694577], [81.4659814418145], [-45.58499078065377], [76.18507814658267], [57.431441986145416], [1.354482600381317], [-16.67507163439133]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
assert score #x bs.ctx matches -87831..-87829
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
assert score #x bs.ctx matches -62743..-62741
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
assert score #x bs.ctx matches -597..-595
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
assert score #x bs.ctx matches 60256..60258
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
assert score #x bs.ctx matches 81465..81467
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
assert score #x bs.ctx matches 71537..71539
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
assert score #x bs.ctx matches 65947..65949
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
assert score #x bs.ctx matches 66796..66798
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
assert score #x bs.ctx matches 76184..76186
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
assert score #x bs.ctx matches 73350..73352
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
assert score #x bs.ctx matches 48032..48034
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
assert score #x bs.ctx matches 18083..18085

data modify storage bs:in spline.sample_hermite set value {points:[[-4.84823301107069], [-51.46192113386119], [69.04084284551945], [87.33765357000877], [25.500724176861468], [95.39081301032365], [59.150215795955006], [-4.361618128545899]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
assert score #x bs.ctx matches -4849..-4847
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
assert score #x bs.ctx matches -4635..-4633
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
assert score #x bs.ctx matches 14745..14747
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
assert score #x bs.ctx matches 42801..42803
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
assert score #x bs.ctx matches 69040..69042
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
assert score #x bs.ctx matches 70047..70049
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
assert score #x bs.ctx matches 46263..46265
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
assert score #x bs.ctx matches 22982..22984
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
assert score #x bs.ctx matches 25500..25502
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
assert score #x bs.ctx matches 44376..44378
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
assert score #x bs.ctx matches 54794..54796
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
assert score #x bs.ctx matches 58976..58978

data modify storage bs:in spline.sample_hermite set value {points:[[-54.215867529550586], [4.1830672286579755], [97.55610470124697], [-52.33799542703335], [-97.03658236592901], [-67.59908961349852], [-48.24922235810125], [73.45164283938047]],step:.25}
function #bs.spline:sample_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[0][0] 1000
assert score #x bs.ctx matches -54217..-54215
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[1][0] 1000
assert score #x bs.ctx matches -27461..-27459
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[2][0] 1000
assert score #x bs.ctx matches 28734..28736
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[3][0] 1000
assert score #x bs.ctx matches 81397..81399
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[4][0] 1000
assert score #x bs.ctx matches 97555..97557
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[5][0] 1000
assert score #x bs.ctx matches 62959..62961
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[6][0] 1000
assert score #x bs.ctx matches 2166..2168
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[7][0] 1000
assert score #x bs.ctx matches -59580..-59578
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[8][0] 1000
assert score #x bs.ctx matches -97038..-97036
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[9][0] 1000
assert score #x bs.ctx matches -102364..-102362
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[10][0] 1000
assert score #x bs.ctx matches -90275..-90273
execute store result score #x bs.ctx run data get storage bs:out spline.sample_hermite[11][0] 1000
assert score #x bs.ctx matches -69371..-69369
