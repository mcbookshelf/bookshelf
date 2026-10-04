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

# minecraft:phantom
execute at @s positioned ~.1000001 ~ ~ unless entity @s[dx=0] positioned ~-.1000001 ~.2000001 ~ unless entity @s[dx=0] positioned ~.0999999 ~-.0000002 ~.0999999 if entity @s[dx=0] run return run function bs.hitbox:get_entity/sleeping
execute store result score #s bs.ctx run attribute @s minecraft:scale get 1000000
execute store result score #d bs.ctx run data get entity @s size
data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,0f,0f,0f]]
execute store result storage bs.hitbox:get_entity out[0][0] float -.0000005 store result storage bs.hitbox:get_entity out[0][2] float -.0000005 store result storage bs.hitbox:get_entity out[0][3] float .0000005 store result storage bs.hitbox:get_entity out[0][5] float .0000005 run compute entity @s integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[900000,{type:"add",inputs:[1,{type:"mul",inputs:[0.15,{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#d"},score:"bs.ctx"}}]}]},{type:"div",left:{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#s"},score:"bs.ctx"}},right:1000000.0}]}}}
data modify storage bs.hitbox:get_entity out[0][4] set compute entity @s float {type:"mul",inputs:[{type:"mul",inputs:[0.5,{type:"add",inputs:[1,{type:"mul",inputs:[0.15,{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#d"},score:"bs.ctx"}}]}]}]},{type:"div",left:{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#s"},score:"bs.ctx"}},right:1000000.0}]}
return 1
