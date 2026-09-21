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

# check for valid intersection: near ≤ far and within ray bounds

data modify storage bs:ctx i set compute default float bs.raycast:internal/aabb/i
data modify storage bs:ctx x set compute default float bs.raycast:internal/aabb/x
data modify storage bs:ctx y set compute default float bs.raycast:internal/aabb/y
data modify storage bs:ctx z set compute default float bs.raycast:internal/aabb/z
data modify storage bs:ctx x set compute default float {\
    "type":"max",\
    "inputs": [\
        {"type": "storage","storage": "bs:ctx","path": "x"},\
        {"type": "storage","storage": "bs:ctx","path": "y"},\
        {"type": "storage","storage": "bs:ctx","path": "z"}\
    ] \
}
tellraw @a {nbt:"x",storage:"bs:ctx"}

execute if predicate bs.raycast:aabb run function bs.raycast:record/block/add

data remove storage bs:lambda hitbox.shape[-1]
execute if data storage bs:lambda hitbox.shape[-1] run function bs.raycast:check/block/aabb
