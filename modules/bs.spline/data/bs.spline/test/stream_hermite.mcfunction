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

data modify storage bs:in spline.stream_hermite set value {points:[[-71.685410569282], [-75.93257780913036], [-83.91891399214254], [-76.48971396977582], [96.17672199810934], [28.137032640158992], [-36.1677770884977], [-16.550480442365156]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches -71686..-71684
await score #packtest.spline.hermite bs.ctx matches -80690..-80688
await score #packtest.spline.hermite bs.ctx matches -77734..-77732
await score #packtest.spline.hermite bs.ctx matches -74811..-74809
await score #packtest.spline.hermite bs.ctx matches -83920..-83918
await score #packtest.spline.hermite bs.ctx matches -67855..-67853
await score #packtest.spline.hermite bs.ctx matches -6950..-6948
await score #packtest.spline.hermite bs.ctx matches 60494..60496
await score #packtest.spline.hermite bs.ctx matches 96176..96178
await score #packtest.spline.hermite bs.ctx matches 80229..80231
await score #packtest.spline.hermite bs.ctx matches 35589..35591
await score #packtest.spline.hermite bs.ctx matches -11844..-11842

data modify storage bs:in spline.stream_hermite set value {points:[[-73.67751296133176], [35.54316472572779], [67.58524495534647], [-98.69940650544922], [-43.47698443835717], [-12.774024877526458], [-24.08149281822132], [72.50278185948119]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches -73679..-73677
await score #packtest.spline.hermite bs.ctx matches -41981..-41979
await score #packtest.spline.hermite bs.ctx matches 13733..13735
await score #packtest.spline.hermite bs.ctx matches 61058..61060
await score #packtest.spline.hermite bs.ctx matches 67584..67586
await score #packtest.spline.hermite bs.ctx matches 36950..36952
await score #packtest.spline.hermite bs.ctx matches 1312..1314
await score #packtest.spline.hermite bs.ctx matches -28955..-28953
await score #packtest.spline.hermite bs.ctx matches -43478..-43476
await score #packtest.spline.hermite bs.ctx matches -45642..-45640
await score #packtest.spline.hermite bs.ctx matches -44440..-44438
await score #packtest.spline.hermite bs.ctx matches -37908..-37906

data modify storage bs:in spline.stream_hermite set value {points:[[27.551357264551783], [44.055149406438176], [31.57306058038651], [-46.88370937027449], [61.107656364816506], [-93.5472174544083], [-4.270790864192421], [-59.23833694512219]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches 27550..27552
await score #packtest.spline.hermite bs.ctx matches 36572..36574
await score #packtest.spline.hermite bs.ctx matches 40929..40931
await score #packtest.spline.hermite bs.ctx matches 39602..39604
await score #packtest.spline.hermite bs.ctx matches 31572..31574
await score #packtest.spline.hermite bs.ctx matches 33979..33981
await score #packtest.spline.hermite bs.ctx matches 52172..52174
await score #packtest.spline.hermite bs.ctx matches 67449..67451
await score #packtest.spline.hermite bs.ctx matches 61107..61109
await score #packtest.spline.hermite bs.ctx matches 40513..40515
await score #packtest.spline.hermite bs.ctx matches 24129..24131
await score #packtest.spline.hermite bs.ctx matches 9889..9891

scoreboard players reset #packtest.spline.hermite bs.ctx
