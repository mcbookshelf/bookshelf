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

# minecraft:goat, its dimensions scaled by 0.7 while long jumping
execute at @s positioned ~.1000001 ~ ~ unless entity @s[dx=0] positioned ~-.1000001 ~.2000001 ~ unless entity @s[dx=0] positioned ~.0999999 ~-.0000002 ~.0999999 if entity @s[dx=0] run return run function bs.hitbox:get_entity/sleeping
execute store result score #s bs.ctx run attribute @s minecraft:scale get 1000000
data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,0f,0f,0f]]
execute store result storage bs.hitbox:get_entity out[0][4] float .000001 store result storage bs.hitbox: i float .000001 run compute entity @s integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"conditional",condition:"bs.hitbox:_get_entity/is_baby",on_true:650000,on_false:1300000},{type:"div",left:{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#s"},score:"bs.ctx"}},right:1000000.0}]}}}
function bs.hitbox:get_entity/registry/goat/long_jump with storage bs.hitbox:
execute store result storage bs.hitbox:get_entity out[0][0] float -.0000005 store result storage bs.hitbox:get_entity out[0][2] float -.0000005 store result storage bs.hitbox:get_entity out[0][3] float .0000005 store result storage bs.hitbox:get_entity out[0][5] float .0000005 run compute entity @s integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"conditional",condition:"bs.hitbox:_get_entity/is_baby",on_true:450000,on_false:900000},{type:"div",left:{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#s"},score:"bs.ctx"}},right:1000000.0}]}}}
return 1
