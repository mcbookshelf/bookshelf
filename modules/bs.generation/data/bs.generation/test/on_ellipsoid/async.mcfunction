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

# A few positions each tick: the lines that are cut by a tick go on where they stopped
scoreboard players set #ward.generation.round.ball bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round.ball bs.data 1",size:[7,7,7],batch:3,on_finished:"scoreboard players add #ward.generation.round.ball bs.data 1000"}
function #bs.generation:on_ellipsoid/yzx
assert score #ward.generation.round.ball bs.data matches 3
await delay 70t
assert score #ward.generation.round.ball bs.data matches 1179

# Started from a command of another generation, it starts at the next tick
scoreboard players set #ward.generation.round.nested bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round.nested bs.data 1",size:[5,5,5]}
data modify storage bs.generation:on_rectangle in set value {run:"function #bs.generation:on_ellipsoid/xzy",size:[2,1]}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.round.nested bs.data matches 0
await delay 1t
assert score #ward.generation.round.nested bs.data matches 162
