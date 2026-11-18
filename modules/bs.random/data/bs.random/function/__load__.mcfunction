# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

forceload add -30000000 1600
setblock -30000000 0 1606 minecraft:decorated_pot

scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]
scoreboard objectives add bs.const dummy [{text:"BS ",color:"dark_gray"},{text:"Constants",color:"aqua"}]

scoreboard players set -1024 bs.const -1024
scoreboard players set 15 bs.const 15
scoreboard players set 41 bs.const 41
scoreboard players set 71 bs.const 71
scoreboard players set 1000 bs.const 1000
scoreboard players set 1024 bs.const 1024
scoreboard players set 15360 bs.const 15360
scoreboard players set 31337 bs.const 31337
scoreboard players set 46337 bs.const 46337
scoreboard players set 1073741824 bs.const 1073741824
