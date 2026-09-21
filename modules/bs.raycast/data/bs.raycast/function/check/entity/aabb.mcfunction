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

# get position relative to ray origin
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.raycast:utils/get_entity_pos with storage bs:data raycast

data modify storage bs:ctx a set compute default float {type:"add",inputs:[{type:"storage","storage":"bs:ctx",path:"_[0]"},{type:"storage","storage":"bs:data",path:"raycast.rx"}]}
data modify storage bs:ctx b set compute default float {type:"add",inputs:[{type:"storage","storage":"bs:ctx",path:"_[1]"},{type:"storage","storage":"bs:data",path:"raycast.ry"}]}
data modify storage bs:ctx c set compute default float {type:"add",inputs:[{type:"storage","storage":"bs:ctx",path:"_[2]"},{type:"storage","storage":"bs:data",path:"raycast.rz"}]}
data modify storage bs:ctx x set compute default float bs.raycast:internal/e_aabb/x
data modify storage bs:ctx y set compute default float bs.raycast:internal/e_aabb/y
data modify storage bs:ctx z set compute default float bs.raycast:internal/e_aabb/z
data modify storage bs:ctx i set compute default float bs.raycast:internal/e_aabb/i
data modify storage bs:ctx x set compute default float {\
    "type":"max",\
    "inputs": [\
        {"type": "storage","storage": "bs:ctx","path": "x"},\
        {"type": "storage","storage": "bs:ctx","path": "y"},\
        {"type": "storage","storage": "bs:ctx","path": "z"}\
    ] \
}

# check for valid intersection: near ≤ far and within ray bounds
execute if predicate bs.raycast:aabb run return run function bs.raycast:record/entity/add

scoreboard players reset @s bs.raycast.id
