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

# level 111111129 => max_points = 1000000002
execute store result storage bs.xp: levels int 1 run xp query @s levels
xp set @s 111111129 levels
execute store result storage bs.xp: points int 1 run xp query @s points
data modify storage bs.xp: points set compute default integer {type:max,inputs:[0,{type:min,inputs:[1000000000,{type:add,inputs:[{type:"from_float",input:{type:mul,inputs:[{type:storage,storage:"bs.xp:add_progress",path:"in.progress"},1000000000]}},{type:storage,storage:"bs.xp:",path:"points"}]}]}]}
function bs.xp:add_progress/run with storage bs.xp:
