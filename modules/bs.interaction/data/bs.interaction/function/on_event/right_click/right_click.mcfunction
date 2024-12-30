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

# Note:
#  Function called when a right click is done on a right click listener.

advancement revoke @s only bs.interaction:right_click
tag @s add bs.interaction.source
execute as @n[type=minecraft:interaction,tag=bs.interaction.listen_right_click,distance=..24,limit=2147483647] run function bs.interaction:on_event/right_click/as_target
tag @s remove bs.interaction.source
