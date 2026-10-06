# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

data modify storage bs.geometry: shapes set from storage bs.geometry:get_signed_distance in

#this function accept an array of 2shapes as input
execute if function bs.geometry:__internal__/error/2array run return fail
#and at least 1 point
execute if function bs.geometry:__internal__/error/need_point run return fail

execute if data storage bs.geometry: shapes[{type:"line"}] run return run function bs.geometry:get_signed_distance/shapes/line

execute if data storage bs.geometry: shapes[{type:"plane"}] run return run function bs.geometry:get_signed_distance/shapes/plane

execute if data storage bs.geometry: shapes[{type:"sphere"}] run return run function bs.geometry:get_signed_distance/shapes/sphere

data modify storage bs.geometry: first set from storage bs:in geometry.shapes[0]
data modify storage bs.geometry: second set from storage bs:in geometry.shapes[1]
execute if data storage bs.geometry: first{type:"point"} if data storage bs.geometry: second{type:"point"} run return run function bs.geometry:get_signed_distance/shapes/point
