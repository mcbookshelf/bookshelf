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

execute store result storage bs:ctx x double 0.001 run scoreboard players get @s bs.link.lx
execute store result storage bs:ctx y double 0.001 run scoreboard players get @s bs.link.ly
execute store result storage bs:ctx z double 0.001 run scoreboard players get @s bs.link.lz

scoreboard players operation $id.suid bs.in = @s bs.link.to
execute at @n[predicate=bs.id:suid_equal,sort=arbitrary] run function bs.link:keep_local_pos/apply with storage bs:ctx
