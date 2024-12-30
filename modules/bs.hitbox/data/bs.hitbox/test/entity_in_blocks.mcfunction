# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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
# @dummy

fill ~-1 ~-1 ~-1 ~1 ~1 ~1 minecraft:air replace minecraft:barrier
setblock ~-1 ~ ~-1 minecraft:bookshelf

## |TEST CASE|: Entity is not inside a block
execute store result score #s bs.ctx run function #bs.hitbox:is_entity_in_blocks {with:{}}
assert score #s bs.ctx matches 0

## |TEST CASE|: Entity not inside a block
tp @s ~ ~ ~
execute store result score #s bs.ctx run function #bs.hitbox:is_entity_in_blocks {with:{}}
assert score #s bs.ctx matches 1
