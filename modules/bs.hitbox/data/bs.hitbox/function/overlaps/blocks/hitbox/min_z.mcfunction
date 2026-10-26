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

scoreboard players remove #k bs.ctx 1
execute positioned ~ ~ ~-1 if entity @s[dx=0] run return run function bs.hitbox:overlaps/blocks/hitbox/min_z
scoreboard players add #k bs.ctx 1
scoreboard players operation #a bs.ctx = #i bs.ctx
scoreboard players operation #c bs.ctx = #k bs.ctx
return run function bs.hitbox:overlaps/blocks/hitbox/y
