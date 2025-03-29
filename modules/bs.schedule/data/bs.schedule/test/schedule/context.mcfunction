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
# @dummy

setblock ~ ~1 ~ minecraft:bookshelf
function #bs.schedule:schedule {run:"execute if block ~ ~1 ~ minecraft:bookshelf run scoreboard players set @s bs.data 1",with:{}}
await score @s bs.data matches 1

execute in minecraft:the_nether run function #bs.schedule:schedule {run:"execute if dimension minecraft:the_nether run scoreboard players set @s bs.data 2",with:{}}
await score @s bs.data matches 2
