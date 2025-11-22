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

execute store result storage bs:ctx x double .0000001 run scoreboard players get $move.vel.x bs.lambda
execute store result storage bs:ctx y double .0000001 run scoreboard players get $move.vel.y bs.lambda
execute store result storage bs:ctx z double .0000001 run scoreboard players get $move.vel.z bs.lambda

$execute if score $move.hit_face bs.lambda matches 5 if score $move.vel.x bs.lambda matches ..-1 run tag @s add bs.move.flag.$(y)
$execute if score $move.hit_face bs.lambda matches 4 if score $move.vel.x bs.lambda matches 1.. run tag @s add bs.move.flag.$(y)
$execute if score $move.hit_face bs.lambda matches 3 if score $move.vel.z bs.lambda matches ..-1 run tag @s add bs.move.flag.$(y)
$execute if score $move.hit_face bs.lambda matches 2 if score $move.vel.z bs.lambda matches 1.. run tag @s add bs.move.flag.$(y)
$execute if score $move.hit_face bs.lambda matches 1 if score $move.vel.y bs.lambda matches ..-1 run tag @s add bs.move.flag.$(y)
$execute if score $move.hit_face bs.lambda matches 0 if score $move.vel.y bs.lambda matches 1.. run tag @s add bs.move.flag.$(y)

execute if score #move.it bs.data matches ..2 unless data storage bs:ctx {x:0d,y:0d,z:0d} at @s run function bs.move:teleport/canonical/run with storage bs:ctx
