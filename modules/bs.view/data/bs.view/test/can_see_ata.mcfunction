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

fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~ ~1 ~1 minecraft:bookshelf

execute at @s positioned ~ ~1 ~.5 store result score #success bs.data run function #bs.view:can_see_ata {with:{}}
execute if score #success bs.data matches 1 run fail "Position must be obstructed when reaching a block"

execute at @s positioned ~ ~1 ~.49 store result score #success bs.data run function #bs.view:can_see_ata {with:{}}
execute if score #success bs.data matches 0 run fail "Position must be unobstructed before reaching a block"
