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

# pufferfish group
execute store result score #s bs.ctx run data get entity @s PuffState
execute if score #s bs.ctx matches 0 run data modify storage bs:out hitbox set value {width:0.35,height:0.35}
execute if score #s bs.ctx matches 1 run data modify storage bs:out hitbox set value {width:0.48999998,height:0.48999998}
execute if score #s bs.ctx matches 2 run data modify storage bs:out hitbox set value {width:0.7,height:0.7}
