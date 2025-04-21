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

data modify storage bs:in spline.stream_catmull_rom set value {points:[[99.644], [-40.501], [-52.618], [82.521], [-60.395], [18.037]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches -40503..-40499
await score #packtest.spline.catmull_rom bs.ctx matches -55986..-55982
await score #packtest.spline.catmull_rom bs.ctx matches -63767..-63763
await score #packtest.spline.catmull_rom bs.ctx matches -62945..-62941
await score #packtest.spline.catmull_rom bs.ctx matches -52620..-52616
await score #packtest.spline.catmull_rom bs.ctx matches -22672..-22668
await score #packtest.spline.catmull_rom bs.ctx matches 23124..23128
await score #packtest.spline.catmull_rom bs.ctx matches 64834..64838
await score #packtest.spline.catmull_rom bs.ctx matches 82519..82523
await score #packtest.spline.catmull_rom bs.ctx matches 61153..61157
await score #packtest.spline.catmull_rom bs.ctx matches 14605..14609
await score #packtest.spline.catmull_rom bs.ctx matches -33715..-33711

data modify storage bs:in spline.stream_catmull_rom set value {points:[[-4.047], [31.285], [99.339], [-8.267], [-29.259], [-39.594]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 31283..31287
await score #packtest.spline.catmull_rom bs.ctx matches 50113..50117
await score #packtest.spline.catmull_rom bs.ctx matches 74244..74248
await score #packtest.spline.catmull_rom bs.ctx matches 93908..93912
await score #packtest.spline.catmull_rom bs.ctx matches 99337..99341
await score #packtest.spline.catmull_rom bs.ctx matches 82757..82761
await score #packtest.spline.catmull_rom bs.ctx matches 51099..51103
await score #packtest.spline.catmull_rom bs.ctx matches 16659..16663
await score #packtest.spline.catmull_rom bs.ctx matches -8269..-8265
await score #packtest.spline.catmull_rom bs.ctx matches -19857..-19853
await score #packtest.spline.catmull_rom bs.ctx matches -24844..-24840
await score #packtest.spline.catmull_rom bs.ctx matches -26792..-26788

data modify storage bs:in spline.stream_catmull_rom set value {points:[[-36.431], [75.159], [98.673], [-16.267], [-18.41], [97.359]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 75157..75161
await score #packtest.spline.catmull_rom bs.ctx matches 90473..90477
await score #packtest.spline.catmull_rom bs.ctx matches 101072..101076
await score #packtest.spline.catmull_rom bs.ctx matches 104592..104596
await score #packtest.spline.catmull_rom bs.ctx matches 98671..98675
await score #packtest.spline.catmull_rom bs.ctx matches 77027..77031
await score #packtest.spline.catmull_rom bs.ctx matches 42805..42809
await score #packtest.spline.catmull_rom bs.ctx matches 7780..7784
await score #packtest.spline.catmull_rom bs.ctx matches -16269..-16265
await score #packtest.spline.catmull_rom bs.ctx matches -27499..-27495
await score #packtest.spline.catmull_rom bs.ctx matches -31760..-31756
await score #packtest.spline.catmull_rom bs.ctx matches -28811..-28807

data modify storage bs:in spline.stream_catmull_rom set value {points:[[-43.571], [94.15], [31.801], [-48.147], [98.657], [48.353]],step:.25,run:"execute store result score #packtest.spline.catmull_rom bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_catmull_rom
await score #packtest.spline.catmull_rom bs.ctx matches 94148..94152
await score #packtest.spline.catmull_rom bs.ctx matches 93041..93045
await score #packtest.spline.catmull_rom bs.ctx matches 76578..76582
await score #packtest.spline.catmull_rom bs.ctx matches 53313..53317
await score #packtest.spline.catmull_rom bs.ctx matches 31799..31803
await score #packtest.spline.catmull_rom bs.ctx matches 7735..7739
await score #packtest.spline.catmull_rom bs.ctx matches -21247..-21243
await score #packtest.spline.catmull_rom bs.ctx matches -43693..-43689
await score #packtest.spline.catmull_rom bs.ctx matches -48149..-48145
await score #packtest.spline.catmull_rom bs.ctx matches -22772..-22768
await score #packtest.spline.catmull_rom bs.ctx matches 23400..23404
await score #packtest.spline.catmull_rom bs.ctx matches 70499..70503
