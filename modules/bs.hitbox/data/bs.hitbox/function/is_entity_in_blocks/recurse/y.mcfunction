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

execute if function bs.hitbox:is_entity_in_blocks/recurse/z run return 1

scoreboard players remove #y bs.ctx 1000000
scoreboard players remove #m bs.ctx 1000000
execute if score #m bs.ctx matches 1.. positioned ~ ~1 ~ if function bs.hitbox:is_entity_in_blocks/recurse/y run return 1
scoreboard players add #y bs.ctx 1000000
scoreboard players add #m bs.ctx 1000000
