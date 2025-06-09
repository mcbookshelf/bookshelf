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

data modify storage bs:in spline.stream_linear set value {points:[[-92.64], [-40.062], [55.003], [-81.721], [-25.817], [-89.297]],step:.25,run:"execute store result score #packtest.spline.linear bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_linear
await score #packtest.spline.linear bs.ctx matches -92642..-92638
await score #packtest.spline.linear bs.ctx matches -79498..-79494
await score #packtest.spline.linear bs.ctx matches -66353..-66349
await score #packtest.spline.linear bs.ctx matches -53208..-53204
await score #packtest.spline.linear bs.ctx matches -40064..-40060
await score #packtest.spline.linear bs.ctx matches -16298..-16294
await score #packtest.spline.linear bs.ctx matches 7469..7473
await score #packtest.spline.linear bs.ctx matches 31235..31239
await score #packtest.spline.linear bs.ctx matches 55001..55005
await score #packtest.spline.linear bs.ctx matches 20820..20824
await score #packtest.spline.linear bs.ctx matches -13361..-13357
await score #packtest.spline.linear bs.ctx matches -47542..-47538

data modify storage bs:in spline.stream_linear set value {points:[[91.374], [71.764], [84.778], [-56.856], [-6.578], [-95.789]],step:.25,run:"execute store result score #packtest.spline.linear bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_linear
await score #packtest.spline.linear bs.ctx matches 91372..91376
await score #packtest.spline.linear bs.ctx matches 86469..86473
await score #packtest.spline.linear bs.ctx matches 81567..81571
await score #packtest.spline.linear bs.ctx matches 76664..76668
await score #packtest.spline.linear bs.ctx matches 71762..71766
await score #packtest.spline.linear bs.ctx matches 75015..75019
await score #packtest.spline.linear bs.ctx matches 78269..78273
await score #packtest.spline.linear bs.ctx matches 81523..81527
await score #packtest.spline.linear bs.ctx matches 84776..84780
await score #packtest.spline.linear bs.ctx matches 49368..49372
await score #packtest.spline.linear bs.ctx matches 13959..13963
await score #packtest.spline.linear bs.ctx matches -21450..-21446

data modify storage bs:in spline.stream_linear set value {points:[[68.362], [88.245], [-78.759], [78.669], [-73.135], [42.038]],step:.25,run:"execute store result score #packtest.spline.linear bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_linear
await score #packtest.spline.linear bs.ctx matches 68360..68364
await score #packtest.spline.linear bs.ctx matches 73331..73335
await score #packtest.spline.linear bs.ctx matches 78301..78305
await score #packtest.spline.linear bs.ctx matches 83272..83276
await score #packtest.spline.linear bs.ctx matches 88243..88247
await score #packtest.spline.linear bs.ctx matches 46492..46496
await score #packtest.spline.linear bs.ctx matches 4741..4745
await score #packtest.spline.linear bs.ctx matches -37010..-37006
await score #packtest.spline.linear bs.ctx matches -78761..-78757
await score #packtest.spline.linear bs.ctx matches -39404..-39400
await score #packtest.spline.linear bs.ctx matches -47..-43
await score #packtest.spline.linear bs.ctx matches 39310..39314

data modify storage bs:in spline.stream_linear set value {points:[[-5.661], [52.884], [34.418], [27.569], [-43.304], [63.433]],step:.25,run:"execute store result score #packtest.spline.linear bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_linear
await score #packtest.spline.linear bs.ctx matches -5663..-5659
await score #packtest.spline.linear bs.ctx matches 8973..8977
await score #packtest.spline.linear bs.ctx matches 23609..23613
await score #packtest.spline.linear bs.ctx matches 38246..38250
await score #packtest.spline.linear bs.ctx matches 52882..52886
await score #packtest.spline.linear bs.ctx matches 48265..48269
await score #packtest.spline.linear bs.ctx matches 43649..43653
await score #packtest.spline.linear bs.ctx matches 39032..39036
await score #packtest.spline.linear bs.ctx matches 34416..34420
await score #packtest.spline.linear bs.ctx matches 32704..32708
await score #packtest.spline.linear bs.ctx matches 30991..30995
await score #packtest.spline.linear bs.ctx matches 29279..29283
