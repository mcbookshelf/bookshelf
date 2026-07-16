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

#this function accept an array of 2shapes as input
execute if function bs.geometry:error/2array run return fail
#and at least 1 point
execute if function bs.geometry:error/need_point run return fail

execute if data storage bs:in geometry.shapes[{type:"line"}] run return run function bs.geometry:sdf/line

execute if data storage bs:in geometry.shapes[{type:"plane"}] run return run function bs.geometry:sdf/plane

execute if data storage bs:in geometry.shapes[{type:"sphere"}] run return run function bs.geometry:sdf/sphere

data modify storage bs:ctx a set from storage bs:in geometry.shapes[0]
data modify storage bs:ctx b set from storage bs:in geometry.shapes[1]
execute if data storage bs:ctx a{type:"point"} if data storage bs:ctx b{type:"point"} run return run function bs.geometry:sdf/point
