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

tag @s add bs.interaction.target
scoreboard players remove @s bs.interaction.hover 1
scoreboard players remove #interaction.active_hover bs.data 1
execute if entity @s[tag=bs.interaction.listen_hover_leave] run function bs.interaction:on_event/hover_leave/dispatch with storage bs:ctx
tag @s remove bs.interaction.target
