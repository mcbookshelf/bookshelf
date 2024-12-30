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

execute store result score #x bs.ctx run data get storage bs:ctx x 1
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 24
execute store result score #x bs.ctx run data get storage bs:ctx x 256
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 16
execute store result score #x bs.ctx run data get storage bs:ctx x 65536
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 8
execute store result score #x bs.ctx run data get storage bs:ctx x 16777216
scoreboard players set #e bs.ctx 0
