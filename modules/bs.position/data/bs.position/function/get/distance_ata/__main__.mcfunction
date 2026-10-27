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

execute summon minecraft:marker run function bs.position:utils/get_pos
data modify storage bs.position: _ set from entity @s Pos

execute store result score $position.get_distance_ata bs.out run return run compute default float {type:"mul",inputs:[{type:"storage",storage:"bs.position:get",path:"in.scale"},{type:"length",inputs:[\
{type:"sub",left:{type:"storage",storage:"bs.position:",path:"_[0]"},right:{type:"storage",storage:"bs.position:",path:"pos[0]"}},\
{type:"sub",left:{type:"storage",storage:"bs.position:",path:"_[1]"},right:{type:"storage",storage:"bs.position:",path:"pos[1]"}},\
{type:"sub",left:{type:"storage",storage:"bs.position:",path:"_[2]"},right:{type:"storage",storage:"bs.position:",path:"pos[2]"}}\
]}]}
