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

execute if predicate {type:"float_value_check",test:{type:"storage",storage:"bs:data",path:"raycast.tb"},value:{type:"storage",storage:"bs:data",path:"raycast.tm"}} run function bs.raycast:react/block
execute if predicate {type:"float_value_check",test:{type:"storage",storage:"bs:data",path:"raycast.te"},value:{type:"storage",storage:"bs:data",path:"raycast.tm"}} positioned as @s as @e[tag=bs.raycast.checked,predicate=bs.raycast:internal/id,distance=..255,limit=1] run function bs.raycast:react/entity

# stop the recursion if piercing is 0
execute if score $raycast.piercing bs.lambda matches 0 run return run data modify storage bs:data raycast.dm set value -2147483648f

data modify storage bs:lambda raycast.prev_entry_distance set from storage bs:data raycast.tm
data modify storage bs:lambda raycast.prev_exit_distance set from storage bs:lambda raycast.exit_distance

data modify storage bs:data raycast.tm set compute default float {type:"min",inputs:[2147483647f,{type:"storage",storage:"bs:data",path:"raycast.tb"},{type:"storage",storage:"bs:data",path:"raycast.te"}]}

execute if predicate bs.raycast:internal/shortest_tm run function bs.raycast:react/any
