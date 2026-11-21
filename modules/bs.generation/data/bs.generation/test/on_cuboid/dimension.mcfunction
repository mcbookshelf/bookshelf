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

# A generation cut by a tick goes on in the dimension where it started
scoreboard players set #ward.generation.cuboid.dimension.the_nether bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if dimension minecraft:the_nether run scoreboard players add #ward.generation.cuboid.dimension.the_nether bs.data 1",size:[3,1,1],batch:1}
execute in minecraft:the_nether run function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.dimension.the_end bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if dimension minecraft:the_end run scoreboard players add #ward.generation.cuboid.dimension.the_end bs.data 1",size:[3,1,1],batch:1}
execute in minecraft:the_end run function #bs.generation:on_cuboid/xyz
await score #ward.generation.cuboid.dimension.the_nether bs.data matches 3
await score #ward.generation.cuboid.dimension.the_end bs.data matches 3
