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

# Every order can start from the command of another generation: it starts at the next tick
scoreboard players set #ward.generation.cuboid_outline.nested bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.cuboid_outline.nested bs.data 1",size:[3,3,3]}
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/xyz",size:[1,1]}
function #bs.generation:on_rectangle/xz
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/xzy",size:[1,1]}
function #bs.generation:on_rectangle/xz
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/yxz",size:[1,1]}
function #bs.generation:on_rectangle/xz
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/yzx",size:[1,1]}
function #bs.generation:on_rectangle/xz
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/zxy",size:[1,1]}
function #bs.generation:on_rectangle/xz
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_cuboid_outline/zyx",size:[1,1]}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.cuboid_outline.nested bs.data matches 0
await delay 1t
assert score #ward.generation.cuboid_outline.nested bs.data matches 156
