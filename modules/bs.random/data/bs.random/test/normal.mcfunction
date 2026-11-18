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


# A spread of 0 gives the mean, rounded
data modify storage bs.random:normal in set value {mean:10.0,spread:0.0}
assert result 10 run compute default integer bs.random:normal
data modify storage bs.random:normal in set value {mean:-2.6,spread:0.0}
assert result -3 run compute default integer bs.random:normal

# 64 draws average near the mean
data modify storage bs.random:normal in set value {mean:10.0,spread:3.0}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 544..736
