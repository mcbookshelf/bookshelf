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

# set a component to 0 depending on the surface that was hit
execute if score $move.hit_face bs.data matches 4..5 store result score $move.vel_remaining.x bs.data run scoreboard players set @s bs.vel.x 0
execute if score $move.hit_face bs.data matches 0..1 store result score $move.vel_remaining.y bs.data run scoreboard players set @s bs.vel.y 0
execute if score $move.hit_face bs.data matches 2..3 store result score $move.vel_remaining.z bs.data run scoreboard players set @s bs.vel.z 0
