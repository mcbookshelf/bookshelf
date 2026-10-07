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

# minecraft:interaction
execute at @s unless entity @s[dx=0] run return 0
data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,0f,0f,0f]]
execute store result storage bs.hitbox:get_entity out[0][0] float -.0000005 store result storage bs.hitbox:get_entity out[0][2] float -.0000005 store result storage bs.hitbox:get_entity out[0][3] float .0000005 store result storage bs.hitbox:get_entity out[0][5] float .0000005 run data get entity @s width 1000000
data modify storage bs.hitbox:get_entity out[0][4] set from entity @s height
return 1
