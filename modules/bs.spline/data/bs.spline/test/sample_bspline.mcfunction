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

data modify storage bs:in spline.sample_bspline set value {points:[[-14.516838523499302], [0.07605742082597544], [-85.22005744780692], [20.4471117241809], [31.83774487326926], [-76.52834774408963]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
assert score #x bs.ctx matches -16573..-16571
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
assert score #x bs.ctx matches -27775..-27773
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
assert score #x bs.ctx matches -40676..-40674
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
assert score #x bs.ctx matches -50730..-50728
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
assert score #x bs.ctx matches -53394..-53392
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
assert score #x bs.ctx matches -45623..-45621
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
assert score #x bs.ctx matches -30373..-30371
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
assert score #x bs.ctx matches -12102..-12100
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
assert score #x bs.ctx matches 4733..4735
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
assert score #x bs.ctx matches 16353..16355
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
assert score #x bs.ctx matches 21682..21684
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
assert score #x bs.ctx matches 20323..20325

data modify storage bs:in spline.sample_bspline set value {points:[[12.136500576518557], [72.90175081300202], [64.2288387148343], [-74.4219708744458], [15.380187634564763], [-36.72138536751475]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
assert score #x bs.ctx matches 61328..61330
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
assert score #x bs.ctx matches 65512..65514
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
assert score #x bs.ctx matches 64410..64412
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
assert score #x bs.ctx matches 57076..57078
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
assert score #x bs.ctx matches 42565..42567
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
assert score #x bs.ctx matches 21021..21023
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
assert score #x bs.ctx matches -3046..-3044
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
assert score #x bs.ctx matches -24036..-24034
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
assert score #x bs.ctx matches -36347..-36345
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
assert score #x bs.ctx matches -36279..-36277
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
assert score #x bs.ctx matches -27719..-27717
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
assert score #x bs.ctx matches -16454..-16452

data modify storage bs:in spline.sample_bspline set value {points:[[62.07746859219708], [-44.82118705893618], [92.40269276934211], [81.6384338317585], [8.818683182210123], [-49.685098183682456]],step:.25}
function #bs.spline:sample_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[0][0] 1000
assert score #x bs.ctx matches -4135..-4133
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[1][0] 1000
assert score #x bs.ctx matches 6263..6265
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[2][0] 1000
assert score #x bs.ctx matches 25793..25795
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[3][0] 1000
assert score #x bs.ctx matches 48326..48328
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[4][0] 1000
assert score #x bs.ctx matches 67737..67739
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[5][0] 1000
assert score #x bs.ctx matches 79144..79146
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[6][0] 1000
assert score #x bs.ctx matches 82644..82646
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[7][0] 1000
assert score #x bs.ctx matches 79580..79582
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[8][0] 1000
assert score #x bs.ctx matches 71295..71297
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[9][0] 1000
assert score #x bs.ctx matches 59107..59109
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[10][0] 1000
assert score #x bs.ctx matches 44233..44235
execute store result score #x bs.ctx run data get storage bs:out spline.sample_bspline[11][0] 1000
assert score #x bs.ctx matches 27868..27870
