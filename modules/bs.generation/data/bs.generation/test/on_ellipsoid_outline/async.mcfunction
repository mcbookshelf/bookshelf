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

# A few positions each tick: the lines cut by a tick go on where they stopped, and the last command runs at the end
scoreboard players set #ward.generation.shell.async bs.data 0
data remove storage ward.generation:shell out
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.shell.async bs.data 1",size:[7,7,7],batch:5,on_finished:"data modify storage ward.generation:shell out.finished set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.shell.async bs.data matches 5
await data storage ward.generation:shell out.finished
assert score #ward.generation.shell.async bs.data matches 98
