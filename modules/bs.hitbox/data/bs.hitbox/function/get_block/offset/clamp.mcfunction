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

execute store result score #u bs.ctx run data get storage bs:out hitbox.offset.x 10000000
execute store result score #v bs.const run data get storage bs:out hitbox.offset.z 10000000

$execute if score #u bs.ctx matches ..$(min) run scoreboard players set #u bs.ctx $(min)
$execute if score #v bs.ctx matches ..$(min) run scoreboard players set #v bs.ctx $(min)
$execute if score #u bs.ctx matches $(max).. run scoreboard players set #u bs.ctx $(max)
$execute if score #v bs.ctx matches $(max).. run scoreboard players set #v bs.ctx $(max)

execute store result storage bs:out hitbox.offset.x double .0000001 run scoreboard players get #u bs.ctx
execute store result storage bs:out hitbox.offset.z double .0000001 run scoreboard players get #v bs.ctx
