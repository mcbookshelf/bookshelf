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

# Modified from https://github.com/Aeldrion/Minecraft-Random
scoreboard players add $random.geometric bs.out 1
execute unless predicate {"condition":"minecraft:value_check","value":{"min":1,"max":1000000000},"range":{"min":1,"max":{"type":"minecraft:score","score":"bs.ctx","target":{"type":"minecraft:fixed","name":"#p"}}}} unless score $random.geometric bs.out matches 1000 run function bs.random:distributions/geometric/loop
