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

execute store result score #n bs.ctx run data get storage bs:data raycast.rb[-1].norm
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

data modify storage bslambda raycast.entry_distance set from storage bs:data raycast.tm
data modify storage bslambda raycast.exit_distance set from storage bs:data raycast.rb[-1].tmax

execute if data storage bs:lambda hitbox run return run function bs.raycast:react/cell

scoreboard players operation $raycast.piercing bs.lambda = #raycast.pb bs.data

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
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
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
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
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
      {type:"storage",storage:"bs:lambda",path:"raycast.entry_distance"},\
      {type:"storage",storage:"bs:data",path:"raycast.uz"}\
    ]\
  },\
  right:{type:"storage",storage:"bs:data",path:"raycast.bz"}\
}

execute store result score $raycast.hit_flag bs.lambda run data get storage bs:data raycast.rb[-1].flag
execute if data storage bs:data raycast.on_entry_point positioned as @s run function bs.raycast:utils/at_entry_point with storage bs:data raycast
execute if data storage bs:data raycast.on_exit_point positioned as @s run function bs.raycast:utils/at_exit_point with storage bs:data raycast

scoreboard players operation #raycast.pb bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.pe bs.data = #raycast.pb bs.data

data remove storage bs:data raycast.rb[-1]
execute unless data storage bs:data raycast.rb[-1] run return run data modify storage bs:data raycast.tb set value 2147483647f
data modify storage bs:data raycast.tb set from storage bs:data raycast.rb[-1].tmin
