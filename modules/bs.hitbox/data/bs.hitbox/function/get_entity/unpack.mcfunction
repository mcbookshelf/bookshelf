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

execute at @s[type=#bs.hitbox:_get_entity/living] positioned ~.1000001 ~ ~ unless entity @s[dx=0] positioned ~-.1000001 ~.2000001 ~ unless entity @s[dx=0] positioned ~.0999999 ~-.0000002 ~.0999999 if entity @s[dx=0] run return run function bs.hitbox:get_entity/sleeping
execute store result score #s bs.ctx run attribute @s[type=#bs.hitbox:_get_entity/living] minecraft:scale get 1000000

data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,0f,0f,0f,1f]]
execute store result storage bs.hitbox:get_entity out[0][0] float -.0000005 store result storage bs.hitbox:get_entity out[0][2] float -.0000005 store result storage bs.hitbox:get_entity out[0][3] float .0000005 store result storage bs.hitbox:get_entity out[0][5] float .0000005 run compute entity @s integer bs.hitbox:_get_entity/width
execute store result storage bs.hitbox:get_entity out[0][4] float .000001 run compute entity @s integer bs.hitbox:_get_entity/height
return 1
