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

execute at @s anchored eyes positioned ^ ^ ^ run summon minecraft:marker ~ ~ ~ {UUID:[I;181,0,0,194]}
execute as B5-0-0-0-C2 run function bs.view:can_see/get_relative_pos
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision"}
data modify storage bs.raycast:cast in merge from storage bs.view:can_see in
data modify storage bs.raycast:cast in.max_distance set compute default float {type:"length",inputs:[{type:"storage",storage:"bs.view:",path:"rel[0]"},{type:"storage",storage:"bs.view:",path:"rel[1]"},{type:"storage",storage:"bs.view:",path:"rel[2]"}]}
execute facing entity @s eyes if function #bs.raycast:cast run return fail
return 1
