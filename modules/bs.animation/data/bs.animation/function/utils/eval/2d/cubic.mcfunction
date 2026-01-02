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

execute store result score #t bs.ctx run data get storage bs:ctx _[0].t
execute store result score #d bs.ctx run data get storage bs:ctx _[0].d
execute store result score #x bs.ctx store result score #y bs.ctx run scoreboard players operation #t bs.ctx /= #d bs.ctx

execute store result score #a bs.ctx run data get storage bs:ctx _[0].p[0]
execute store result score #b bs.ctx run data get storage bs:ctx _[0].p[1]
execute store result score #c bs.ctx run data get storage bs:ctx _[0].p[2]
execute store result score #d bs.ctx run data get storage bs:ctx _[0].p[3] -1
scoreboard players operation #x bs.ctx *= #d bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
scoreboard players operation #x bs.ctx += #c bs.ctx
scoreboard players operation #x bs.ctx *= #t bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
scoreboard players operation #x bs.ctx -= #b bs.ctx
scoreboard players operation #x bs.ctx *= #t bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
scoreboard players operation #x bs.ctx += #a bs.ctx

execute store result score #a bs.ctx run data get storage bs:ctx _[0].p[4]
execute store result score #b bs.ctx run data get storage bs:ctx _[0].p[5]
execute store result score #c bs.ctx run data get storage bs:ctx _[0].p[6]
execute store result score #d bs.ctx run data get storage bs:ctx _[0].p[7] -1
scoreboard players operation #y bs.ctx *= #d bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
scoreboard players operation #y bs.ctx += #c bs.ctx
scoreboard players operation #y bs.ctx *= #t bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
scoreboard players operation #y bs.ctx -= #b bs.ctx
scoreboard players operation #y bs.ctx *= #t bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
scoreboard players operation #y bs.ctx += #a bs.ctx
