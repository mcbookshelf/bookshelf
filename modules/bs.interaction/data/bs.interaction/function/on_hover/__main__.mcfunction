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

execute unless entity @s[type=minecraft:interaction] run return fail

data modify storage bs.interaction: event set from storage bs.interaction:on_hover in
execute if data storage bs.interaction: event{lazy:false} unless data storage bs.interaction: event{executor:"source"} unless data storage bs.interaction: event{executor:"target"} run function bs.interaction:utils/interpret with storage bs.interaction: event
execute if data storage bs.interaction: event{executor:"target"} run data modify storage bs.interaction: event.executor set value "@s"
execute if data storage bs.interaction: event{executor:"source"} run data modify storage bs.interaction: event.executor set value "@p[distance=0,tag=bs.interaction.source]"
execute unless data storage bs.interaction: event.executor run return fail

tag @s add bs.interaction.listen_hover
tag @s add bs.interaction.is_hoverable
data modify entity @s data."bs.interaction".hover prepend from storage bs.interaction: event
execute unless score @s bs.interaction.hover matches -2147483648.. store result score @s bs.interaction.hover run scoreboard players add #counter bs.interaction.hover 1
schedule function bs.interaction:utils/process 1t replace
return 1
