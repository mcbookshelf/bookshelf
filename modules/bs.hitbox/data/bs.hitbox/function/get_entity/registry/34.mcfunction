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

# item_frame group
execute store result score #f bs.ctx run data get entity @s Facing
execute if score #f bs.ctx matches 0 run data modify storage bs:out hitbox set value {shape:[[2.0, 14.46875, 2.0, 14.0, 16.0, 14.0]]}
execute if score #f bs.ctx matches 1 run data modify storage bs:out hitbox set value {shape:[[2.0, 0.0, 2.0, 14.0, 1.53125, 14.0]]}
execute if score #f bs.ctx matches 2 run data modify storage bs:out hitbox set value {shape:[[2.0, 2.0, 14.46875, 14.0, 14.0, 16.0]]}
execute if score #f bs.ctx matches 3 run data modify storage bs:out hitbox set value {shape:[[2.0, 2.0, 0.0, 14.0, 14.0, 1.53125]]}
execute if score #f bs.ctx matches 4 run data modify storage bs:out hitbox set value {shape:[[14.46875, 2.0, 2.0, 16.0, 14.0, 14.0]]}
execute if score #f bs.ctx matches 5 run data modify storage bs:out hitbox set value {shape:[[0.0, 2.0, 2.0, 1.53125, 14.0, 14.0]]}
