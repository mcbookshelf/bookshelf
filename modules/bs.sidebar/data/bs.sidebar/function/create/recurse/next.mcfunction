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

$scoreboard players set $$(line) $(id) -$(line)
$scoreboard players display name $$(line) $(id) {storage:"bs:ctx",nbt:"_.left",interpret:true}
$scoreboard players display numberformat $$(line) $(id) fixed {storage:"bs:ctx",nbt:"_.right",interpret:true}

$execute if score #l bs.ctx matches 1 run data modify storage bs:ctx _.dyn append value {target:'name $$(line) $(id)'}
execute if score #l bs.ctx matches 1 run data modify storage bs:ctx _.dyn[-1].value set from storage bs:ctx _.left
$execute if score #r bs.ctx matches 1 run data modify storage bs:ctx _.dyn append value {target:'numberformat $$(line) $(id) fixed'}
execute if score #r bs.ctx matches 1 run data modify storage bs:ctx _.dyn[-1].value set from storage bs:ctx _.right

execute store result storage bs:ctx _.line int 1 run scoreboard players add #i bs.ctx 1

data remove storage bs:ctx _.contents[0]
execute unless data storage bs:ctx _.contents[0] run return 1

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
