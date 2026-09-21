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

execute if score #raycast.pe bs.data matches 0.. run scoreboard players remove #raycast.pe bs.data 1

scoreboard players set $raycast.hit_flag bs.lambda -1
execute store result score #n bs.ctx run data get storage bs:data raycast.re[-1].norm
execute if score #n bs.ctx matches 1 store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_ux",\
  on_true:4,\
  on_false:5\
}
execute if score #n bs.ctx matches 2 store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_ux",\
  on_true:4,\
  on_false:5\
}
execute if score #n bs.ctx matches 3 store result score $raycast.hit_face bs.lambda run compute default integer {\
  type:"conditional",\
  condition:"bs.raycast:internal/positive_ux",\
  on_true:4,\
  on_false:5\
}
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pe bs.data


data modify storage bs:lambda raycast.entry_distance set from storage bs:data raycast.tm
data modify storage bs:data raycast.tmin set from storage bs:lambda raycast.entry_distance
data modify storage bs:lambda raycast.exit_distance set from storage bs:data raycast.re[-1].tmax
data modify storage bs:data raycast.tmax set from storage bs:lambda raycast.exit_distance

data modify storage bs:lambda raycast.exit_point.x set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.exit_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.ux"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].x"}\
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
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].y"}\
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
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].z"}\
}

data modify storage bs:lambda raycast.entry_point.x set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.ux"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].x"}\
}
data modify storage bs:lambda raycast.entry_point.y set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.uy"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].y"}\
}
data modify storage bs:lambda raycast.entry_point.z set compute default float {\
  type:"sub",\
  left:{\
    "type":"mul",\
    "inputs":[\
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.uz"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.re[-1].z"}\
}

execute if data storage bs:data raycast.on_targeted_entity at @s run function bs.raycast:utils/on_targeted_entity with storage bs:data raycast
execute if data storage bs:data raycast.on_entry_point run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point run function bs.raycast:utils/at_exit_point with storage bs:data raycast

scoreboard players operation #raycast.pe bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pb bs.data = #raycast.pe bs.data

data remove storage bs:data raycast.re[-1]
execute unless data storage bs:data raycast.re[-1] run return run data modify storage bs:data raycast.tz set value 2147483647f
data modify storage bs:data raycast.tz set from storage bs:data raycast.re[-1].tmin
execute store result score #raycast.id bs.data run data get storage bs:data raycast.re[-1].id
