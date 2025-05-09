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

$scoreboard objectives add $(id) dummy
$scoreboard objectives modify $(id) displayname $(name)

execute store result storage bs:ctx _.line int 1 run scoreboard players set #i bs.ctx 0

data modify storage bs:ctx _.left set from storage bs:ctx _.contents[0]
data modify storage bs:ctx _.left set from storage bs:ctx _.contents[0][0]
data modify entity @s text set from storage bs:ctx _.left
data modify entity @s CustomName set from storage bs:ctx _.left
execute store success score #l bs.ctx run data modify entity @s text set from entity @s CustomName
data modify storage bs:ctx _.right set value ""
data modify storage bs:ctx _.right set from storage bs:ctx _.contents[0][1]
data modify entity @s text set from storage bs:ctx _.right
data modify entity @s CustomName set from storage bs:ctx _.right
execute store success score #r bs.ctx run data modify entity @s text set from entity @s CustomName

function bs.sidebar:create/recurse/next with storage bs:ctx _
$data remove storage bs:data sidebar.'$(id)'
$data modify storage bs:data sidebar.'$(id)' set from storage bs:ctx _.dyn
