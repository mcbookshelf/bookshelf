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

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-15.846948950139364, 13.382251358348853], [61.16773896530111, -51.23164411008212], [85.41638322555173, 82.1850096478822], [22.354776873009214, -26.173965188209365]],time:0.174}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches 69610..69612
assert score #y bs.ctx matches -36750..-36748

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-41.558782626033675, -18.967970804496616], [-66.41686246560417, -58.26650675771656], [-12.022154885840152, 63.887814055061256], [-62.213874236349874, 38.586004079114446]],time:0.389}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches -46178..-46176
assert score #y bs.ctx matches -15656..-15654

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-0.6559967915334539, -12.977873407155329], [-10.116969277987536, -19.59348969361794], [23.217332505277085, 81.26501260314114], [75.87466091594351, -71.77698320104693]],time:0.036}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches -9646..-9644
assert score #y bs.ctx matches -17603..-17601

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[71.77605713459172, 23.689931764310728], [-90.5361112646694, -63.093715898021976], [-36.58583979629522, 44.71676043815481], [26.44694203303058, 77.84744348283493]],time:0.466}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches -80292..-80290
assert score #y bs.ctx matches -21454..-21452

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[51.426767235759655, 76.15762038689175], [-64.50846136070851, 30.526866681619083], [89.39687864554847, -38.72717094169013], [-99.29561775891487, -7.111781188790729]],time:0.701}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches 60091..60093
assert score #y bs.ctx matches -24691..-24689

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-69.0322988373254, -66.88177264542966], [-2.7507774815179005, 47.19726146935477], [70.75163527353453, -17.959535221642426], [38.379438938481314, 22.059749213573497]],time:0.57}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches 46160..46162
assert score #y bs.ctx matches 12155..12157

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-18.838219879112003, -65.62671964310651], [9.47736822882024, -94.1434588974842], [66.91486936262308, -97.36736001429564], [-90.19162734745754, 52.59100940978354]],time:0.315}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches 32708..32710
assert score #y bs.ctx matches -102235..-102233

data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[-84.75363732130586, 71.39494492469595], [13.89269013638139, -33.12780365908954], [11.272541435136986, -18.720635649580004], [29.89579209993235, 20.27261923621053]],time:0.05}
function #bs.spline:evaluate_catmull_rom
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_catmull_rom[1] 1000
assert score #x bs.ctx matches 16020..16022
assert score #y bs.ctx matches -35121..-35119
