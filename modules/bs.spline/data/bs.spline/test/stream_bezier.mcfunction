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

data modify storage bs:in spline.stream_bezier set value {points:[[62.397], [-84.278], [50.278], [29.766], [-54.711], [-52.184], [-67.473], [96.217], [-37.052], [63.341]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches 62395..62399
await score #packtest.spline.bezier bs.ctx matches -1698..-1694
await score #packtest.spline.bezier bs.ctx matches -1232..-1228
await score #packtest.spline.bezier bs.ctx matches 22890..22894
await score #packtest.spline.bezier bs.ctx matches 29764..29768
await score #packtest.spline.bezier bs.ctx matches -18918..-18914
await score #packtest.spline.bezier bs.ctx matches -44801..-44797
await score #packtest.spline.bezier bs.ctx matches -57711..-57707
await score #packtest.spline.bezier bs.ctx matches -67475..-67471
await score #packtest.spline.bezier bs.ctx matches 7904..7908
await score #packtest.spline.bezier bs.ctx matches 21668..21672
await score #packtest.spline.bezier bs.ctx matches 23565..23569

data modify storage bs:in spline.stream_bezier set value {points:[[-94.935], [31.396], [-87.226], [29.054], [-56.293], [-10.354], [-98.967], [74.377], [8.899], [-13.542]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches -94937..-94933
await score #packtest.spline.bezier bs.ctx matches -38620..-38616
await score #packtest.spline.bezier bs.ctx matches -29173..-29169
await score #packtest.spline.bezier bs.ctx matches -21612..-21608
await score #packtest.spline.bezier bs.ctx matches 29052..29056
await score #packtest.spline.bezier bs.ctx matches -14496..-14492
await score #packtest.spline.bezier bs.ctx matches -33734..-33730
await score #packtest.spline.bezier bs.ctx matches -53584..-53580
await score #packtest.spline.bezier bs.ctx matches -98969..-98965
await score #packtest.spline.bezier bs.ctx matches -9336..-9332
await score #packtest.spline.bezier bs.ctx matches 17163..17167
await score #packtest.spline.bezier bs.ctx matches 6952..6956

data modify storage bs:in spline.stream_bezier set value {points:[[4.194], [36.631], [-88.41], [-47.18], [56.132], [-61.103], [-21.453], [46.421], [43.241], [26.313]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches 4192..4196
await score #packtest.spline.bezier bs.ctx matches 4051..4055
await score #packtest.spline.bezier bs.ctx matches -24792..-24788
await score #packtest.spline.bezier bs.ctx matches -51987..-51983
await score #packtest.spline.bezier bs.ctx matches -47182..-47178
await score #packtest.spline.bezier bs.ctx matches -5153..-5149
await score #packtest.spline.bezier bs.ctx matches -10445..-10441
await score #packtest.spline.bezier bs.ctx matches -27674..-27670
await score #packtest.spline.bezier bs.ctx matches -21455..-21451
await score #packtest.spline.bezier bs.ctx matches 17023..17027
await score #packtest.spline.bezier bs.ctx matches 34229..34233
await score #packtest.spline.bezier bs.ctx matches 35534..35538

data modify storage bs:in spline.stream_bezier set value {points:[[-85.013], [-52.82], [37.392], [-40.098], [2.373], [-11.04], [-86.946], [-81.172], [23.242], [-89.771]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches -85015..-85011
await score #packtest.spline.bezier bs.ctx matches -53519..-53515
await score #packtest.spline.bezier bs.ctx matches -21426..-21422
await score #packtest.spline.bezier bs.ctx matches -9900..-9896
await score #packtest.spline.bezier bs.ctx matches -40100..-40096
await score #packtest.spline.bezier bs.ctx matches -18828..-18824
await score #packtest.spline.bezier bs.ctx matches -19133..-19129
await score #packtest.spline.bezier bs.ctx matches -41633..-41629
await score #packtest.spline.bezier bs.ctx matches -86948..-86944
await score #packtest.spline.bezier bs.ctx matches -69061..-69057
await score #packtest.spline.bezier bs.ctx matches -43815..-43811
await score #packtest.spline.bezier bs.ctx matches -40842..-40838
