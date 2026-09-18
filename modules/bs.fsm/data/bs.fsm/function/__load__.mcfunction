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

execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f,alignment:"center"}

scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]

execute unless data storage bs:data fsm run data modify storage bs:data fsm set value { machines: {}, listened_transitions: [], ticks: [] }

# A world load leaves the chunks holding the bound entities behind for a moment, and a missing entity is read as a dead one,
# so we push the loops back to give the entities time to come back instead of having their machines evicted.
# An entity whose chunk is still not loaded once the delay has elapsed is still dropped.
# This also runs on a plain reload, where it merely holds the running machines for a second.
execute if data storage bs:data fsm.ticks[0] run schedule function bs.fsm:run/tick 20t
execute if data storage bs:data fsm.listened_transitions[0] run schedule function bs.fsm:run/evaluate_transitions 20t
