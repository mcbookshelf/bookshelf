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

execute positioned ~ ~4 ~ unless entity @s[dx=0] positioned ~ ~-4 ~ run return run function bs.hitbox:get_entity/registry/painting/height3
scoreboard players add #h bs.ctx 8
execute positioned ~ ~4 ~ run function bs.hitbox:get_entity/registry/painting/height3
