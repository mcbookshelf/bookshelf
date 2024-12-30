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
# @dummy

xp set @s 5 levels
xp set @s 5 points
execute store result score #r bs.ctx run function #bs.xp:get_remaining_points
assert score #r bs.ctx matches 12

xp set @s 21 levels
xp set @s 12 points
execute store result score #r bs.ctx run function #bs.xp:get_remaining_points
assert score #r bs.ctx matches 55

xp set @s 42 levels
xp set @s 18 points
execute store result score #r bs.ctx run function #bs.xp:get_remaining_points
assert score #r bs.ctx matches 202
