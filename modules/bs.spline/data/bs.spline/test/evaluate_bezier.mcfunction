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

data modify storage bs:in spline.evaluate_bezier set value {points:[[-73.61861929717634, 5.115239162142714], [-44.47656488215637, 81.28411139546392], [64.93135938554957, 48.34403713365353], [-20.023439571535235, -42.56618472344154]],time:0.941}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches -6961..-6959
assert score #y bs.ctx matches -27092..-27090

data modify storage bs:in spline.evaluate_bezier set value {points:[[-36.34154811652734, 94.20970876862933], [14.015897639374003, 92.18768780503166], [29.570016765912612, 81.37299422291295], [20.192190470824272, 37.17310064426991]],time:0.071}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches -26139..-26137
assert score #y bs.ctx matches 93636..93638

data modify storage bs:in spline.evaluate_bezier set value {points:[[13.998177290114626, -78.4542011155797], [30.89378016653413, 12.106182845178964], [-11.72828450863814, 4.2428505932975895], [-76.56982919654875, 84.03582590197627]],time:0.441}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches 4824..4826
assert score #y bs.ctx matches -109..-107

data modify storage bs:in spline.evaluate_bezier set value {points:[[-59.854011586934796, 7.447520943284005], [-57.39883912452661, -79.42404617794023], [-34.07249823812725, 90.94722695398974], [-87.35129162859354, 20.772559241266663]],time:0.564}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches -53272..-53270
assert score #y bs.ctx matches 16637..16639

data modify storage bs:in spline.evaluate_bezier set value {points:[[-99.24971748761808, -54.05481977485771], [-52.68995802500407, -74.90656627215778], [-47.68747577439871, -35.87519914155544], [92.80916073891848, 57.820251984620114]],time:0.797}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches 22515..22517
assert score #y bs.ctx matches 7560..7562

data modify storage bs:in spline.evaluate_bezier set value {points:[[96.82364290355864, -9.075113959611073], [-85.26358217213294, 64.79449344213003], [62.84841139951723, -6.195433392018984], [-6.342635111000476, 35.016522262444994]],time:0.346}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches 3728..3730
assert score #y bs.ctx matches 26222..26224

data modify storage bs:in spline.evaluate_bezier set value {points:[[-82.06622329067905, -75.00087472451841], [-55.318072639333124, -87.65303311472523], [8.240915485101226, -49.767940633182064], [-73.71367343237449, -13.143478391364027]],time:0.341}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches -49092..-49090
assert score #y bs.ctx matches -72369..-72367

data modify storage bs:in spline.evaluate_bezier set value {points:[[-16.496427260107467, -48.021820996299766], [44.13498672160563, 71.81313933921587], [11.323517019142187, 27.414601540979433], [17.636037172179968, 39.431823678741125]],time:0.528}
function #bs.spline:evaluate_bezier
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bezier[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bezier[1] 1000
assert score #x bs.ctx matches 20905..20907
assert score #y bs.ctx matches 36918..36920
