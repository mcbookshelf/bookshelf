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

# Note: Thanks to XanBelOr for the idea of using the effects_changed trigger advancement

# Get current health, max_health
data modify storage bs:ctx h set from entity @s Health
data modify storage bs:ctx m set from entity @s attributes[{id:"minecraft:max_health"}].base

# Add incoming points to the healing modifier and clamp to max possible healing
$data modify storage bs:ctx f set compute default float {type:"min",inputs:[{type:"add",inputs:[$(points)f,{type:"mul",inputs:[0.00001,{type:"from_int",input:{type:"score",target:"this",score:"bs.hmod"}}]}]},{type:"add",inputs:[{type:"storage",storage:"bs:ctx",path:"m"},{type:"negate",input:{type:"storage",storage:"bs:ctx",path:"h"}}]}]}
execute store result score @s bs.hmod run data get storage bs:ctx f 100000

# Apply health change: reduction is instant, increase waits for instant_health to take effect
execute if score @s bs.hmod matches ..-1 run return run function bs.health:utils/decrease_health
execute if score @s bs.hmod matches 0.. run return run function bs.health:utils/increase_health
