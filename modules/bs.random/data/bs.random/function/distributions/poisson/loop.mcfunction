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
scoreboard players add #k bs.ctx 1

execute store result score #m bs.ctx run random value 0..65536
scoreboard players operation #p bs.ctx /= 65536 bs.const
scoreboard players operation #p bs.ctx *= #m bs.ctx

execute if score #p bs.ctx > #e bs.ctx run function bs.random:distributions/poisson/loop
