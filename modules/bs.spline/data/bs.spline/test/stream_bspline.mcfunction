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

data modify storage bs:in spline.stream_bspline set value {points:[[-18.944033265584736], [-68.62221683383798], [-33.80098960900686], [-82.51670354036256], [-53.92233951007617], [-69.27111000708406]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches -54540..-54538
await score #packtest.spline.bspline bs.ctx matches -54194..-54192
await score #packtest.spline.bspline bs.ctx matches -51193..-51191
await score #packtest.spline.bspline bs.ctx matches -48161..-48159
await score #packtest.spline.bspline bs.ctx matches -47725..-47723
await score #packtest.spline.bspline bs.ctx matches -51653..-51651
await score #packtest.spline.bspline bs.ctx matches -58290..-58288
await score #packtest.spline.bspline bs.ctx matches -65120..-65118
await score #packtest.spline.bspline bs.ctx matches -69633..-69631
await score #packtest.spline.bspline bs.ctx matches -70048..-70046
await score #packtest.spline.bspline bs.ctx matches -67525..-67523
await score #packtest.spline.bspline bs.ctx matches -63960..-63958

data modify storage bs:in spline.stream_bspline set value {points:[[-66.46513145629329], [-55.139443593563996], [90.84855095971949], [-25.82419936969083], [-66.60927617997831], [72.20846297844253]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches -32696..-32694
await score #packtest.spline.bspline bs.ctx matches -9859..-9857
await score #packtest.spline.bspline bs.ctx matches 15187..15189
await score #packtest.spline.bspline bs.ctx matches 36233..36235
await score #packtest.spline.bspline bs.ctx matches 47071..47073
await score #packtest.spline.bspline bs.ctx matches 43409..43411
await score #packtest.spline.bspline bs.ctx matches 28620..28622
await score #packtest.spline.bspline bs.ctx matches 7995..7997
await score #packtest.spline.bspline bs.ctx matches -13177..-13175
await score #packtest.spline.bspline bs.ctx matches -30218..-30216
await score #packtest.spline.bspline bs.ctx matches -40895..-40893
await score #packtest.spline.bspline bs.ctx matches -43588..-43586

data modify storage bs:in spline.stream_bspline set value {points:[[-59.04208795530344], [-50.31167541140831], [-28.30109803806397], [7.557626980101432], [0.33340095441995743], [21.619027510409452]],step:.25,run:"execute store result score #packtest.spline.bspline bs.ctx run data get storage bs:lambda spline.point[0] 1000"}
function #bs.spline:stream_bspline
await score #packtest.spline.bspline bs.ctx matches -48099..-48097
await score #packtest.spline.bspline bs.ctx matches -43840..-43838
await score #packtest.spline.bspline bs.ctx matches -38742..-38740
await score #packtest.spline.bspline bs.ctx matches -32796..-32794
await score #packtest.spline.bspline bs.ctx matches -25994..-25992
await score #packtest.spline.bspline bs.ctx matches -18476..-18474
await score #packtest.spline.bspline bs.ctx matches -10982..-10980
await score #packtest.spline.bspline bs.ctx matches -4401..-4399
await score #packtest.spline.bspline bs.ctx matches 376..378
await score #packtest.spline.bspline bs.ctx matches 2796..2798
await score #packtest.spline.bspline bs.ctx matches 3641..3643
await score #packtest.spline.bspline bs.ctx matches 4031..4033

scoreboard players reset #packtest.spline.bspline bs.ctx
