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

data modify storage bs:ctx _ set value {octaves:4,persistence:.5,lacunarity:2.0,size:16,scale:1}
$scoreboard players set #w bs.ctx $(width)
$scoreboard players set #h bs.ctx $(height)
$data modify storage bs:ctx _ merge value $(with)
execute store result storage bs:ctx _.scale double .000001 run data get storage bs:ctx _.scale 1000

execute store result score $random.fractal_noise_2d.octaves bs.in run data get storage bs:ctx _.octaves
execute store result score $random.fractal_noise_2d.persistence bs.in run data get storage bs:ctx _.persistence 1000
execute store result score $random.fractal_noise_2d.lacunarity bs.in run data get storage bs:ctx _.lacunarity 1000
execute if data storage bs:ctx _.seed store result score $random.fractal_noise_2d.seed bs.in run data get storage bs:ctx _.seed
execute unless data storage bs:ctx _.seed store result score $random.fractal_noise_2d.seed bs.in run random value 1.. bs.random:fractal_noise_mat_2d

scoreboard players set #k bs.ctx 1000
execute store result score #c bs.ctx run data get storage bs:ctx _.size
scoreboard players operation #k bs.ctx /= #c bs.ctx

execute store result score $random.fractal_noise_2d.y bs.in run scoreboard players set #y bs.ctx 0
data modify storage bs:out random.fractal_noise_mat_2d set value []
execute if score #h bs.ctx matches 1.. if score #w bs.ctx matches 1.. run function bs.random:noise/fractal_noise_mat_2d/yloop
