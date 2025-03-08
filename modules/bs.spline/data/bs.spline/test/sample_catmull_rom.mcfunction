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

data modify storage bs:in spline.sample_catmull_rom set value {points:[[25.17856013139199], [-4.2609735652333995], [98.4292900189935], [-27.346561623510084], [-64.96039545186983], [50.138524289871214]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
assert score #x bs.ctx matches -4262..-4260
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
assert score #x bs.ctx matches 17475..17477
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
assert score #x bs.ctx matches 53104..53106
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
assert score #x bs.ctx matches 85723..85725
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
assert score #x bs.ctx matches 98428..98430
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
assert score #x bs.ctx matches 80982..80984
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
assert score #x bs.ctx matches 44309..44311
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
assert score #x bs.ctx matches 3252..3254
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
assert score #x bs.ctx matches -27348..-27346
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
assert score #x bs.ctx matches -46529..-46527
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
assert score #x bs.ctx matches -61209..-61207
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
assert score #x bs.ctx matches -68362..-68360

data modify storage bs:in spline.sample_catmull_rom set value {points:[[-24.959387866377455], [-44.53839568973987], [90.57676426221087], [50.58877175089273], [-36.196956637409585], [71.84771592416979]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
assert score #x bs.ctx matches -44539..-44537
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
assert score #x bs.ctx matches -17534..-17532
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
assert score #x bs.ctx matches 24294..24296
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
assert score #x bs.ctx matches 65482..65484
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
assert score #x bs.ctx matches 90576..90578
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
assert score #x bs.ctx matches 93988..93990
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
assert score #x bs.ctx matches 84451..84453
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
assert score #x bs.ctx matches 67979..67981
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
assert score #x bs.ctx matches 50588..50590
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
assert score #x bs.ctx matches 27615..27617
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
assert score #x bs.ctx matches -2057..-2055
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
assert score #x bs.ctx matches -27104..-27102

data modify storage bs:in spline.sample_catmull_rom set value {points:[[-13.099022866920379], [37.56483116013371], [22.39636879069505], [-91.60103761002205], [-83.11961144140065], [-21.491919289308044]],step:.25}
function #bs.spline:sample_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[0][0] 1000
assert score #x bs.ctx matches 37564..37566
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[1][0] 1000
assert score #x bs.ctx matches 40717..40719
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[2][0] 1000
assert score #x bs.ctx matches 40271..40273
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[3][0] 1000
assert score #x bs.ctx matches 34679..34681
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[4][0] 1000
assert score #x bs.ctx matches 22395..22397
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[5][0] 1000
assert score #x bs.ctx matches -2026..-2024
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[6][0] 1000
assert score #x bs.ctx matches -36081..-36079
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[7][0] 1000
assert score #x bs.ctx matches -69398..-69396
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[8][0] 1000
assert score #x bs.ctx matches -91602..-91600
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[9][0] 1000
assert score #x bs.ctx matches -99339..-99337
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[10][0] 1000
assert score #x bs.ctx matches -98338..-98336
execute store result score #x bs.ctx run data get storage bs:out spline.sample_catmull_rom[11][0] 1000
assert score #x bs.ctx matches -91848..-91846
