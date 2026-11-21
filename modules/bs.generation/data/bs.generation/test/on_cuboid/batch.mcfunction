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

scoreboard players set #ward.generation.first bs.data 0
scoreboard players set #ward.generation.second bs.data 0

# Each generation does its whole batch each tick, whatever its size and whatever the others do
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.first bs.data 1",size:[3000,1,1],batch:1500}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.second bs.data 1",size:[900,1,1],batch:300}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.first bs.data matches 1500
assert score #ward.generation.second bs.data matches 300
await delay 4t
assert score #ward.generation.first bs.data matches 3000
assert score #ward.generation.second bs.data matches 900

# A batch under 1 does one position each tick
scoreboard players set #ward.generation.third bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.third bs.data 1",size:[2,1,1],batch:0}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.third bs.data matches 1
await delay 1t
assert score #ward.generation.third bs.data matches 2
