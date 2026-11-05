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

data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/outline",on_block:"execute as @n[tag=bs.view.origin] run function bs.view:utils/aimed with storage bs.view:at_aimed_block in"}
data modify storage bs.raycast:cast in merge from storage bs.view:at_aimed_block in

tag @s add bs.view.origin
scoreboard players set #view.hit bs.data 0
execute at @s anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast
tag @s remove bs.view.origin
return run execute if score #view.hit bs.data matches 1
