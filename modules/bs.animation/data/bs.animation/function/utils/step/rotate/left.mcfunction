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

data modify storage bs:ctx _ append from storage bs:ctx _[0]
data remove storage bs:ctx _[0]
execute store result storage bs:ctx _[0].t int 1 run scoreboard players operation #t bs.ctx -= #n bs.ctx
execute store result score #n bs.ctx run data get storage bs:ctx _[0].d 1000
execute if score #n bs.ctx matches ..999 run scoreboard players set #n bs.ctx 1000
execute if score #t bs.ctx >= #n bs.ctx run function bs.animation:utils/step/rotate/left
