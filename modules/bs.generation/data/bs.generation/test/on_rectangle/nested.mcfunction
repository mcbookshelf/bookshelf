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
scoreboard players set #ward.generation.rectangle.nested bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.nested bs.data 1",size:[3,3]}
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/xy",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/xz",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/yx",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/yz",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/zx",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
data modify storage bs.generation:on_cuboid in set value {run:"function #bs.generation:on_rectangle/zy",size:[1,1,1]}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.rectangle.nested bs.data matches 0
await delay 1t
assert score #ward.generation.rectangle.nested bs.data matches 54
