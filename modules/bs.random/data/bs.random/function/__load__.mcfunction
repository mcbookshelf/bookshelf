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

forceload add -30000000 1600
setblock -30000000 0 1606 minecraft:decorated_pot

scoreboard objectives add bs.const dummy [{"text":"BS ","color":"dark_gray"},{"text":"Constants","color":"aqua"}]
scoreboard objectives add bs.ctx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Context","color":"aqua"}]
scoreboard objectives add bs.out dummy [{"text":"BS ","color":"dark_gray"},{"text":"Output","color":"aqua"}]
scoreboard objectives add bs.in dummy [{"text":"BS ","color":"dark_gray"},{"text":"Input","color":"aqua"}]

scoreboard players set -1000 bs.const -1000
scoreboard players set 2 bs.const 2
scoreboard players set 8 bs.const 8
scoreboard players set 10 bs.const 10
scoreboard players set 12 bs.const 12
scoreboard players set 13 bs.const 13
scoreboard players set 14 bs.const 14
scoreboard players set 24 bs.const 24
scoreboard players set 78 bs.const 78
scoreboard players set 100 bs.const 100
scoreboard players set 1000 bs.const 1000
scoreboard players set 10000 bs.const 10000
scoreboard players set 65536 bs.const 65536
scoreboard players set 26645 bs.const 26645
scoreboard players set 29447 bs.const 29447
scoreboard players set 32544 bs.const 32544
scoreboard players set 35967 bs.const 35967
scoreboard players set 39750 bs.const 39750
scoreboard players set 43930 bs.const 43930
scoreboard players set 48550 bs.const 48550
scoreboard players set 53656 bs.const 53656
scoreboard players set 59299 bs.const 59299
scoreboard players set 1000000000 bs.const 1000000000

execute unless data storage bs:const log.messages[{namespaces: ["bs.random"]}] run data modify storage bs:const log.messages[{namespaces: ["bs"]}].namespaces append value "bs.random"
