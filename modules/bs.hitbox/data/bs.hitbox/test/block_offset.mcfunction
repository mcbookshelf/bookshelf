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

# Block offset at random position
setblock ~ ~ ~ minecraft:poppy
function #bs.hitbox:get_block_shape
assert not data storage bs:out hitbox{ offset: { x: 0.0, z: 0.0 } }

# Block offset at fixed position (0 0)
forceload add 0 0
setblock 0 0 0 minecraft:poppy
execute positioned 0 0 0 run function #bs.hitbox:get_block_shape
assert data storage bs:out hitbox{ shape: [[5.0, 0.0, 5.0, 11.0, 10.0, 11.0]], offset: { x: -0.25, z: -0.25 } }
