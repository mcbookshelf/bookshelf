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

execute unless loaded ~ ~ ~ run return fail
execute unless data storage bs.raycast:pierce in.blocks unless data storage bs.raycast:pierce in.entities run return fail
data modify storage bs.raycast: ray set value {max_distance:16,_block:"bs.raycast:pierce/block/check",_entity:"bs.raycast:pierce/entity/check",_nearest:"bs.raycast:pierce/entity/react",_react:"bs.raycast:pierce/react",selector:"",_span:2147483647,_shift_x:0,_shift_z:0}
data modify storage bs.raycast: ray merge from storage bs.raycast:pierce in
execute unless data storage bs.raycast: ray.on_block unless data storage bs.raycast: ray.on_entry unless data storage bs.raycast: ray.on_exit run data remove storage bs.raycast: ray.blocks

kill B5-0-0-0-C1
summon minecraft:marker ~ ~ ~ {UUID:[I;181,0,0,193],Tags:["bs.raycast.omit"]}
execute as B5-0-0-0-C1 run function bs.raycast:pierce/init
return run execute if score #raycast.max bs.data matches -2147483648
