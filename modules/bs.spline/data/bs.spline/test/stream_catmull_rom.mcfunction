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

data modify storage bs:in spline.stream_catmull_rom set value {points:[[-32.408022729087634], [49.49652214664107], [-30.876322010205982], [-2.7407031020755284], [-21.52146536934545], [-14.26398986938564]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 49496..49498
await score #packtest.spline.catmull_rom bs.ctx matches 38269..38271
await score #packtest.spline.catmull_rom bs.ctx matches 12670..12672
await score #packtest.spline.catmull_rom bs.ctx matches -14610..-14608
await score #packtest.spline.catmull_rom bs.ctx matches -30877..-30875
await score #packtest.spline.catmull_rom bs.ctx matches -30373..-30371
await score #packtest.spline.catmull_rom bs.ctx matches -20659..-20657
await score #packtest.spline.catmull_rom bs.ctx matches -9020..-9018
await score #packtest.spline.catmull_rom bs.ctx matches -2742..-2740
await score #packtest.spline.catmull_rom bs.ctx matches -4748..-4746
await score #packtest.spline.catmull_rom bs.ctx matches -10827..-10825
await score #packtest.spline.catmull_rom bs.ctx matches -17558..-17556

data modify storage bs:in spline.stream_catmull_rom set value {points:[[42.95908496046695], [94.46577643066053], [-7.564728582570538], [99.41112923171181], [-19.677531811869173], [45.29677315170372]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 94465..94467
await score #packtest.spline.catmull_rom bs.ctx matches 74854..74856
await score #packtest.spline.catmull_rom bs.ctx matches 39983..39985
await score #packtest.spline.catmull_rom bs.ctx matches 6845..6847
await score #packtest.spline.catmull_rom bs.ctx matches -7566..-7564
await score #packtest.spline.catmull_rom bs.ctx matches 9781..9783
await score #packtest.spline.catmull_rom bs.ctx matches 46988..46990
await score #packtest.spline.catmull_rom bs.ctx matches 83663..83665
await score #packtest.spline.catmull_rom bs.ctx matches 99410..99412
await score #packtest.spline.catmull_rom bs.ctx matches 81219..81221
await score #packtest.spline.catmull_rom bs.ctx matches 42491..42493
await score #packtest.spline.catmull_rom bs.ctx matches 2450..2452

data modify storage bs:in spline.stream_catmull_rom set value {points:[[98.83686659164312], [31.989320273407543], [14.990704255042985], [-74.3996973163392], [-20.04606425136342], [-40.11705648781167]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 31988..31990
await score #packtest.spline.catmull_rom bs.ctx matches 25930..25932
await score #packtest.spline.catmull_rom bs.ctx matches 24898..24900
await score #packtest.spline.catmull_rom bs.ctx matches 23161..23163
await score #packtest.spline.catmull_rom bs.ctx matches 14990..14992
await score #packtest.spline.catmull_rom bs.ctx matches -5637..-5635
await score #packtest.spline.catmull_rom bs.ctx matches -34165..-34163
await score #packtest.spline.catmull_rom bs.ctx matches -60463..-60461
await score #packtest.spline.catmull_rom bs.ctx matches -74401..-74399
await score #packtest.spline.catmull_rom bs.ctx matches -69175..-69173
await score #packtest.spline.catmull_rom bs.ctx matches -51556..-51554
await score #packtest.spline.catmull_rom bs.ctx matches -31771..-31769

scoreboard players reset #packtest.spline.catmull_rom bs.ctx
