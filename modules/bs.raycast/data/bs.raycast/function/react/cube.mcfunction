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

execute if score #raycast.pb bs.data matches 0.. run scoreboard players remove #raycast.pb bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pb bs.data

data modify storage bs:lambda raycast.exit_distance set compute default float {\
  "type":"min",\
  "inputs":[\
    {"type":"storage","storage":"bs:data","path":"raycast.lx"},\
    {"type":"storage","storage":"bs:data","path":"raycast.ly"},\
    {"type":"storage","storage":"bs:data","path":"raycast.lz"}\
  ]\
}
data modify storage bs:data raycast.tmax set from storage bs:lambda raycast.exit_distance

data modify storage bs:data raycast.tm set compute default float {\
  "type":"max",\
  "inputs":[\
    "bs.raycast:internal/decrement_lx",\
    "bs.raycast:internal/decrement_ly",\
    "bs.raycast:internal/decrement_lz"\
  ]\
}
data modify storage bs:data raycast.tmin set from storage bs:data raycast.tm


data modify storage bs:lambda raycast.targeted_block.x set compute default float {\
  "type":"mul",\
  "inputs":[\
    {"type":"conditional",condition:"bs.raycast:internal/positive_ux",on_true:1,on_false:-1},\
    {\
      "type":"div",\
      "left":"bs.raycast:internal/decrement_lx",\
      "right":{type:"storage",storage:"bs:data",path:"raycast.dx"}\
    }\
  ]\
}
data modify storage bs:lambda raycast.targeted_block.y set compute default float {\
  "type":"mul",\
  "inputs":[\
    {"type":"conditional",condition:"bs.raycast:internal/positive_uy",on_false:-1,on_true:1},\
    {\
      "type":"div",\
      "left":"bs.raycast:internal/decrement_ly",\
      "right":{type:"storage",storage:"bs:data",path:"raycast.dy"}\
    }\
  ]\
}
data modify storage bs:lambda raycast.targeted_block.z set compute default float {\
  "type":"mul",\
  "inputs":[\
    {"type":"conditional",condition:"bs.raycast:internal/positive_uz",on_false:-1,on_true:1},\
    {\
      "type":"div",\
      "left":"bs.raycast:internal/decrement_lz",\
      "right":{type:"storage",storage:"bs:data",path:"raycast.dz"}\
    }\
  ]\
}

data modify storage bs:data raycast.bx set compute default float {\
  type:"add",\
  inputs:[\
    {\
      "type":"mul",\
      "inputs":[\
        {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.x"}\
      ]\
    },\
    {type:"storage",storage:"bs:data",path:"raycast.rx"}\
  ]\
}
data modify storage bs:data raycast.by set compute default float {\
  type:"add",\
  inputs:[\
    {\
      "type":"mul",\
      "inputs":[\
        {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.y"}\
      ]\
    },\
    {type:"storage",storage:"bs:data",path:"raycast.ry"}\
  ]\
}
data modify storage bs:data raycast.bz set compute default float {\
  type:"add",\
  inputs:[\
    {\
      "type":"mul",\
      "inputs":[\
        {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.z"}\
      ]\
    },\
    {type:"storage",storage:"bs:data",path:"raycast.rz"}\
  ]\
}

data modify storage bs:lambda raycast.targeted_block.x set compute default float {\
  "type":"add",\
  "inputs":[\
    {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.x"},\
    {type:"storage",storage:"bs:data",path:"raycast.x"}\
  ]\
}
data modify storage bs:lambda raycast.targeted_block.y set compute default float {\
  "type":"add",\
  "inputs":[\
    {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.y"},\
    {type:"storage",storage:"bs:data",path:"raycast.y"}\
  ]\
}
data modify storage bs:lambda raycast.targeted_block.z set compute default float {\
  "type":"add",\
  "inputs":[\
    {type:"storage",storage:"bs:lambda",path:"raycast.targeted_block.z"},\
    {type:"storage",storage:"bs:data",path:"raycast.z"}\
  ]\
}

data modify storage bs:lambda raycast.exit_point.x set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.exit_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.ux"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.bx"}\
}
data modify storage bs:lambda raycast.exit_point.y set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.exit_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.uy"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.by"}\
}
data modify storage bs:lambda raycast.exit_point.z set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.exit_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.uz"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.bz"}\
}



data modify storage bs:lambda raycast.entry_point.x set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:data",path:"raycast.tm"},\
      {type:"storage",storage:"bs:data",path:"raycast.ux"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.bx"}\
}
data modify storage bs:lambda raycast.entry_point.y set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:data",path:"raycast.tm"},\
      {type:"storage",storage:"bs:data",path:"raycast.uy"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.by"}\
}
data modify storage bs:lambda raycast.entry_point.z set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:data",path:"raycast.tm"},\
      {type:"storage",storage:"bs:data",path:"raycast.uz"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.bz"}\
}



execute store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_ux",\
  on_true:4,\
  on_false:5\
}
execute if predicate {type:"float_value_check",test:"bs.raycast:internal/decrement_lz",value:{type:"storage",storage:"bs:data",path:"raycast.tm"}} store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_uz",\
  on_true:2,\
  on_false:3\
}
execute if predicate {type:"float_value_check",test:"bs.raycast:internal/decrement_ly",value:{type:"storage",storage:"bs:data",path:"raycast.tm"}} store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_uy",\
  on_true:0,\
  on_false:1\
}

#tellraw @a {score:{name:"$raycast.hit_face",objective:"bs.lambda"}}

execute if data storage bs:data raycast.on_targeted_block run function bs.raycast:utils/on_targeted_block with storage bs:data raycast
execute if data storage bs:data raycast.on_entry_point positioned as @s run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point positioned as @s run function bs.raycast:utils/at_exit_point with storage bs:data raycast

execute if score $raycast.piercing bs.lambda matches 0 run return run data modify storage bs:data raycast.dm set value -2147483648f

data modify storage bs:lambda raycast.prev_entry_distance set from storage bs:data raycast.tm
data modify storage bs:lambda raycast.prev_exit_distance set from storage bs:lambda raycast.exit_distance

data modify storage bs:data raycast.tm set from storage bs:data raycast.te
scoreboard players operation #raycast.pb bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pe bs.data = #raycast.pb bs.data
