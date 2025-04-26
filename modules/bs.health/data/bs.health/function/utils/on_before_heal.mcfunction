# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# This function runs before effects are ticked
# Skip execution if the player doesn't need healing, but keep advancements set for optimization
execute unless score @s bs.hmod matches 1.. run return 0
execute store result score @s bs.hval run data get entity @s Health 100000
advancement revoke @s only bs.health:on_hurt
