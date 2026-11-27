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

scoreboard players set #t bs.ctx 0
execute store result score #h bs.ctx run data get storage bs.random:fractal_noise in.seed
execute store result score #o bs.ctx run data get storage bs.random:fractal_noise in.octaves
execute store result score #p bs.ctx run data get storage bs.random:fractal_noise in.persistence 1000
execute store result score #l bs.ctx run data get storage bs.random:fractal_noise in.lacunarity 1024

execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/x
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/y
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/z

execute store result score #s bs.ctx run compute default integer bs.random:_fractal_noise/3d/s
scoreboard players operation #x bs.ctx += #s bs.ctx
scoreboard players operation #y bs.ctx += #s bs.ctx
scoreboard players operation #z bs.ctx += #s bs.ctx
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t0
execute if score #o bs.ctx matches ..1 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t1
execute if score #o bs.ctx matches ..2 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t2
execute if score #o bs.ctx matches ..3 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t3
execute if score #o bs.ctx matches ..4 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t4
execute if score #o bs.ctx matches ..5 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t5
execute if score #o bs.ctx matches ..6 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t6
execute if score #o bs.ctx matches ..7 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t7
execute if score #o bs.ctx matches ..8 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t8
execute if score #o bs.ctx matches ..9 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t9
execute if score #o bs.ctx matches ..10 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t10
execute if score #o bs.ctx matches ..11 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t11
execute if score #o bs.ctx matches ..12 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t12
execute if score #o bs.ctx matches ..13 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t13
execute if score #o bs.ctx matches ..14 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t14
execute if score #o bs.ctx matches ..15 run return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out

scoreboard players add #h bs.ctx 1
execute store result score #x bs.ctx run compute default integer bs.random:_fractal_noise/nx
execute store result score #y bs.ctx run compute default integer bs.random:_fractal_noise/ny
execute store result score #z bs.ctx run compute default integer bs.random:_fractal_noise/nz
execute store result score #u bs.ctx run compute default integer bs.random:_fractal_noise/3d/u
execute store result score #v bs.ctx run compute default integer bs.random:_fractal_noise/3d/v
execute store result score #w bs.ctx run compute default integer bs.random:_fractal_noise/3d/w
execute store result score #t bs.ctx run compute default integer bs.random:_fractal_noise/3d/t15
return run data modify storage bs.random:fractal_noise out set compute default float bs.random:_fractal_noise/out
