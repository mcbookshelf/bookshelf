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
execute if predicate {"condition":"minecraft:value_check","value":{"min":1,"max":1000000000},"range":{"min":1,"max":{"type":"minecraft:score","score":"bs.ctx","target":{"type":"minecraft:fixed","name":"#p"}}}} run scoreboard players add $random.binomial bs.out 1
scoreboard players remove #n bs.ctx 1
execute if score #n bs.ctx matches 1.. run function bs.random:distributions/binomial/loop
