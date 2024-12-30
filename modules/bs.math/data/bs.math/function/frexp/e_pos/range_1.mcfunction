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

execute store result score #x bs.ctx run data get storage bs:ctx x .000000000000000000000000000012621774483536188886587657044524579674771302961744368076324462890625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 120
execute store result score #x bs.ctx run data get storage bs:ctx x .0000000000000000000000000032311742677852643549664402033982923967414535582065582275390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 112
execute store result score #x bs.ctx run data get storage bs:ctx x .00000000000000000000000082718061255302767487140869206996285356581211090087890625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 104
execute store result score #x bs.ctx run data get storage bs:ctx x .000000000000000000000211758236813575084767080625169910490512847900390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run scoreboard players set #e bs.ctx 96
