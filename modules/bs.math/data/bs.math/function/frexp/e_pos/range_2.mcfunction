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

execute store result score #x bs.ctx run data get storage bs:ctx x .0000000000000000000542101086242752217003726400434970855712890625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 88
execute store result score #x bs.ctx run data get storage bs:ctx x .00000000000000001387778780781445675529539585113525390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 80
execute store result score #x bs.ctx run data get storage bs:ctx x .000000000000003552713678800500929355621337890625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 72
execute store result score #x bs.ctx run data get storage bs:ctx x .0000000000009094947017729282379150390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 64
