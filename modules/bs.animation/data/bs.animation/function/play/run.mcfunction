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

data modify storage bs.animation: stack append value {}
data modify storage bs.animation: stack[-1].nbt.data set from entity @s data
$data modify storage bs.animation: stack[-1]._ append from storage bs.animation: stack[-1].nbt.data."bs.animation"[{id:"$(id)"}]
execute unless data storage bs.animation: stack[-1]._[0] run return run function bs.animation:utils/fail
$data remove storage bs.animation: stack[-1].nbt.data."bs.animation"[{id:"$(id)"}]

execute if data storage bs.animation:play in{loop:0b} run data remove storage bs.animation: stack[-1]._[].l
execute if data storage bs.animation:play in{loop:1b} run data modify storage bs.animation: stack[-1]._[].l set value 1b
data modify storage bs.animation: stack[-1]._[].v set compute default integer {type:"storage",storage:"bs.animation:play",path:"in.interval",fallback:1}
data modify storage bs.animation: stack[-1]._[].s set from storage bs.animation:play in.step
execute store result score #w bs.ctx store result storage bs.animation: stack[-1]._[].w int 1 run function bs.animation:utils/process/schedule with storage bs.animation: stack[-1]._[0]
execute unless score @s bs.anim < #w bs.ctx run scoreboard players operation @s bs.anim = #w bs.ctx

function bs.animation:play/loop with storage bs.animation: stack[-1]._[0]
data modify entity @s {} merge from storage bs.animation: stack[-1].nbt
return run data remove storage bs.animation: stack[-1]
