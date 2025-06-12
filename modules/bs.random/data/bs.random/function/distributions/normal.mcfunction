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

$data modify storage bs:ctx _ set value {m:$(mean),s:$(spread)}
execute store result score #m bs.ctx run data get storage bs:ctx _.m 100
execute store result score #s bs.ctx run data get storage bs:ctx _.s 100

scoreboard players set $random.normal bs.out 0
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx
execute store result score #r bs.ctx run random value -100..100
scoreboard players operation $random.normal bs.out += #r bs.ctx

scoreboard players operation $random.normal bs.out *= #s bs.ctx
scoreboard players operation $random.normal bs.out /= 200 bs.const
scoreboard players operation $random.normal bs.out += #m bs.ctx
return run scoreboard players operation $random.normal bs.out /= 100 bs.const
