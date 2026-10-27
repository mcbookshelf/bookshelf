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

rotate B5-0-0-0-1 ~ ~
data modify storage bs.position: rotation set from entity B5-0-0-0-1 Rotation

# X' = z * sin(h) + x * cos(h)
execute store result score #x bs.ctx run compute default float {type:"add",inputs:[\
    {type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.z",target:"this"}},{type:"sin",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]},\
    {type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.x",target:"this"}},{type:"cos",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]}\
    ]}

# Y' = (z * cos(h) - x * sin(h)) * sin(v) + y * cos(v)
execute store result score #y bs.ctx run compute default float {type:"add",inputs:[\
    {type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.y",target:"this"}},{type:"cos",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[1]"}]}}]},\
    {type:"mul",inputs:[{type:"sin",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[1]"}]}},\
        {type:"sub",\
        left:{type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.z",target:"this"}},{type:"cos",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]},\
        right:{type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.x",target:"this"}},{type:"sin",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]}\
}]}]}

# Z' = (z * cos(h) - x * sin(h)) * cos(v) - y * sin(v)
execute store result score #z bs.ctx run compute default float {type:"sub",\
    right:{type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.y",target:"this"}},{type:"sin",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[1]"}]}}]},\
    left:{type:"mul",inputs:[{type:"cos",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[1]"}]}},\
        {type:"sub",\
        left:{type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.z",target:"this"}},{type:"cos",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]},\
        right:{type:"mul",inputs:[{type:"from_int",input:{type:"score",score:"bs.pos.x",target:"this"}},{type:"sin",input:{type:"mul",inputs:[0.01745329252,{type:"storage",storage:"bs.position:",path:"rotation[0]"}]}}]}\
}]}}

scoreboard players operation @s bs.pos.x = #x bs.ctx
scoreboard players operation @s bs.pos.y = #y bs.ctx
scoreboard players operation @s bs.pos.z = #z bs.ctx
