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

scoreboard players set @s bs.pos.x 577
scoreboard players set @s bs.pos.y 577
scoreboard players set @s bs.pos.z 577

execute rotated -45 -35.265 run function #bs.position:canonical_to_local

assert score @s bs.pos.x matches -1..1
assert score @s bs.pos.y matches -1..1
assert score @s bs.pos.z matches 999..1001
