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

scoreboard objectives add bs.const dummy [{"text":"BS ","color":"dark_gray"},{"text":"Constants","color":"aqua"}]
scoreboard objectives add bs.ctx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Context","color":"aqua"}]

scoreboard objectives add bs.link.rx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link relative X","color":"aqua"}]
scoreboard objectives add bs.link.ry dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link relative Y","color":"aqua"}]
scoreboard objectives add bs.link.rz dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link relative Z","color":"aqua"}]
scoreboard objectives add bs.link.lx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link local X","color":"aqua"}]
scoreboard objectives add bs.link.ly dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link local Y","color":"aqua"}]
scoreboard objectives add bs.link.lz dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link local Z","color":"aqua"}]
scoreboard objectives add bs.link.lv dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link local V","color":"aqua"}]
scoreboard objectives add bs.link.lh dummy [{"text":"BS ","color":"dark_gray"},{"text":"Link local H","color":"aqua"}]
scoreboard objectives add bs.link.to dummy [{"text":"BS ","color":"dark_gray"},{"text":"Linked to","color":"aqua"}]

scoreboard players set 10 bs.const 10
