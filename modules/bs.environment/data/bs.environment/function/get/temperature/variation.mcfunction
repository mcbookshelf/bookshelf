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

execute store result score #v bs.ctx run data get entity @s Pos[1]
kill @s

execute if score #v bs.ctx matches ..80 run return run scoreboard players get #t bs.ctx
scoreboard players remove #v bs.ctx 80
scoreboard players operation #v bs.ctx *= 125000 bs.const
return run scoreboard players operation #t bs.ctx -= #v bs.ctx
