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

execute unless score @s bs.interaction.id matches 1.. store result score @s bs.interaction.id run scoreboard players add #counter bs.interaction.id 1
execute store result storage bs:ctx y int 1 run scoreboard players get @s bs.interaction.id

return run function bs.interaction:register/utils/register_listener with storage bs:ctx
