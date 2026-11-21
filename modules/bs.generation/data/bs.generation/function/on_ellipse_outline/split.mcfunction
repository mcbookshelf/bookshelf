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

scoreboard players set #generation.part bs.data 2
scoreboard players operation #generation.end bs.data = #generation.skip bs.data
scoreboard players operation #generation.end bs.data += #generation.length bs.data
scoreboard players operation #generation.i bs.data = #generation.length bs.data
execute store result storage bs.generation: tasks[0].jump_far int 1 run compute default integer {type:"sub",left:{type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.ni"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.skip"}}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.length"}}}
