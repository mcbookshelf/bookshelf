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

execute store result storage bs.raycast: ray._middle double 0.000000476837158203125 run scoreboard players get #raycast.block bs.data
data modify storage bs.raycast: ray._reach set compute default integer {type:"add",inputs:[{type:"floor_div",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#raycast.block"}},right:2097152},17]}
execute at @s run function bs.raycast:cast/custom/scan with storage bs.raycast: ray
execute unless score #raycast.max bs.data matches -2147483648 run function bs.raycast:cast/block/emit
