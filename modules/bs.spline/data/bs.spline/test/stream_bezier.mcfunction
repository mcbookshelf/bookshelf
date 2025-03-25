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

data modify storage bs:in spline.stream_bezier set value {points:[[28.471051753192967], [-15.366544250964026], [29.855992805633775], [90.16968861329482], [84.60747506921632], [-34.01844162893208], [-50.47075460693187], [-56.88077803564793], [19.23100041735313], [39.12143867678296]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches 28470..28472
await score #packtest.spline.bezier bs.ctx matches 11135..11137
await score #packtest.spline.bezier bs.ctx matches 20263..20265
await score #packtest.spline.bezier bs.ctx matches 48919..48921
await score #packtest.spline.bezier bs.ctx matches 90169..90171
await score #packtest.spline.bezier bs.ctx matches 68161..68163
await score #packtest.spline.bezier bs.ctx matches 23932..23934
await score #packtest.spline.bezier bs.ctx matches -22338..-22336
await score #packtest.spline.bezier bs.ctx matches -50472..-50470
await score #packtest.spline.bezier bs.ctx matches -41974..-41972
await score #packtest.spline.bezier bs.ctx matches -15538..-15536
await score #packtest.spline.bezier bs.ctx matches 15829..15831

data modify storage bs:in spline.stream_bezier set value {points:[[-36.70078566227828], [99.82992221913824], [-44.73931807454454], [-88.24674289357772], [-33.56170282789448], [63.601788848735765], [-11.86166425250083], [-5.3622965362641395], [-31.01191944109803], [47.29830364740721]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches -36702..-36700
await score #packtest.spline.bezier bs.ctx matches 18961..18963
await score #packtest.spline.bezier bs.ctx matches 5040..5042
await score #packtest.spline.bezier bs.ctx matches -42639..-42637
await score #packtest.spline.bezier bs.ctx matches -88248..-88246
await score #packtest.spline.bezier bs.ctx matches -42630..-42628
await score #packtest.spline.bezier bs.ctx matches -1250..-1248
await score #packtest.spline.bezier bs.ctx matches 15728..15730
await score #packtest.spline.bezier bs.ctx matches -11863..-11861
await score #packtest.spline.bezier bs.ctx matches -10889..-10887
await score #packtest.spline.bezier bs.ctx matches -9212..-9210
await score #packtest.spline.bezier bs.ctx matches 5930..5932

data modify storage bs:in spline.stream_bezier set value {points:[[12.516903108933406], [-47.07094952393904], [-78.85087186125928], [-31.99093230533414], [-74.10652440391073], [-58.30803481760209], [26.18896966142256], [-96.87702373033243], [26.92572946003962], [22.214892144591445]],step:.25,run:"execute store result score #packtest.spline.bezier bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bezier
await score #packtest.spline.bezier bs.ctx matches 12516..12518
await score #packtest.spline.bezier bs.ctx matches -26167..-26165
await score #packtest.spline.bezier bs.ctx matches -49656..-49654
await score #packtest.spline.bezier bs.ctx matches -53186..-53184
await score #packtest.spline.bezier bs.ctx matches -31992..-31990
await score #packtest.spline.bezier bs.ctx matches -52551..-52549
await score #packtest.spline.bezier bs.ctx matches -50382..-50380
await score #packtest.spline.bezier bs.ctx matches -24472..-24470
await score #packtest.spline.bezier bs.ctx matches 26188..26190
await score #packtest.spline.bezier bs.ctx matches -25689..-25687
await score #packtest.spline.bezier bs.ctx matches -20182..-20180
await score #packtest.spline.bezier bs.ctx matches 7516..7518

scoreboard players reset #packtest.spline.bezier bs.ctx
