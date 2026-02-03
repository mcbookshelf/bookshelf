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

scoreboard players reset @s bs.animation.tick
data modify storage bs:data animation append value {}
data modify storage bs:data animation[-1].nbt.data set from entity @s data
data modify storage bs:data animation[-1].def set from storage bs:data animation[-1].nbt.data."bs.animation"
execute unless data storage bs:data animation[-1].def[-1] run return run function bs.animation:utils/fail

data remove storage bs:data animation[-1].nbt.data."bs.animation"
function bs.animation:utils/proc/loop
data modify entity @s {} merge from storage bs:data animation[-1].nbt
data remove storage bs:data animation[-1]
