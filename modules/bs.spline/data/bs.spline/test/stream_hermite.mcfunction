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

data modify storage bs:in spline.stream_hermite set value {points:[[40.018], [-84.904], [10.803], [-60.581], [-83.79], [-73.0], [7.079], [29.402]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches 40016..40020
await score #packtest.spline.hermite bs.ctx matches 21230..21234
await score #packtest.spline.hermite bs.ctx matches 18716..18720
await score #packtest.spline.hermite bs.ctx matches 19548..19552
await score #packtest.spline.hermite bs.ctx matches 10801..10805
await score #packtest.spline.hermite bs.ctx matches -14523..-14519
await score #packtest.spline.hermite bs.ctx matches -46767..-46763
await score #packtest.spline.hermite bs.ctx matches -73875..-73871
await score #packtest.spline.hermite bs.ctx matches -83792..-83788
await score #packtest.spline.hermite bs.ctx matches -69123..-69119
await score #packtest.spline.hermite bs.ctx matches -39799..-39795
await score #packtest.spline.hermite bs.ctx matches -9755..-9751

data modify storage bs:in spline.stream_hermite set value {points:[[-51.602], [61.991], [-26.599], [-57.264], [-40.972], [-33.325], [-22.715], [3.046]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches -51604..-51600
await score #packtest.spline.hermite bs.ctx matches -30286..-30282
await score #packtest.spline.hermite bs.ctx matches -21070..-21066
await score #packtest.spline.hermite bs.ctx matches -20871..-20867
await score #packtest.spline.hermite bs.ctx matches -26601..-26597
await score #packtest.spline.hermite bs.ctx matches -33517..-33513
await score #packtest.spline.hermite bs.ctx matches -38577..-38573
await score #packtest.spline.hermite bs.ctx matches -41241..-41237
await score #packtest.spline.hermite bs.ctx matches -40974..-40970
await score #packtest.spline.hermite bs.ctx matches -38254..-38250
await score #packtest.spline.hermite bs.ctx matches -34110..-34106
await score #packtest.spline.hermite bs.ctx matches -28834..-28830

data modify storage bs:in spline.stream_hermite set value {points:[[77.848], [95.758], [13.808], [-72.773], [-51.329], [33.366], [37.216], [35.557]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches 77846..77850
await score #packtest.spline.hermite bs.ctx matches 74417..74421
await score #packtest.spline.hermite bs.ctx matches 58887..58891
await score #packtest.spline.hermite bs.ctx matches 36827..36831
await score #packtest.spline.hermite bs.ctx matches 13806..13810
await score #packtest.spline.hermite bs.ctx matches -12517..-12513
await score #packtest.spline.hermite bs.ctx matches -40172..-40168
await score #packtest.spline.hermite bs.ctx matches -57122..-57118
await score #packtest.spline.hermite bs.ctx matches -51331..-51327
await score #packtest.spline.hermite bs.ctx matches -25508..-25504
await score #packtest.spline.hermite bs.ctx matches 3736..3740
await score #packtest.spline.hermite bs.ctx matches 27582..27586

data modify storage bs:in spline.stream_hermite set value {points:[[-65.312], [27.645], [-39.899], [82.767], [-62.183], [21.067], [-87.865], [-18.936]],step:.25,run:"execute store result score #packtest.spline.hermite bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_hermite
await score #packtest.spline.hermite bs.ctx matches -65314..-65310
await score #packtest.spline.hermite bs.ctx matches -54021..-54017
await score #packtest.spline.hermite bs.ctx matches -56321..-56317
await score #packtest.spline.hermite bs.ctx matches -56764..-56760
await score #packtest.spline.hermite bs.ctx matches -39901..-39897
await score #packtest.spline.hermite bs.ctx matches -30035..-30031
await score #packtest.spline.hermite bs.ctx matches -46116..-46112
await score #packtest.spline.hermite bs.ctx matches -64660..-64656
await score #packtest.spline.hermite bs.ctx matches -62185..-62181
await score #packtest.spline.hermite bs.ctx matches -57722..-57718
await score #packtest.spline.hermite bs.ctx matches -73236..-73232
await score #packtest.spline.hermite bs.ctx matches -89645..-89641
