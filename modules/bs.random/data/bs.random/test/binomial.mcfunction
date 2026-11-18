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


# Every trial succeeds with a probability of 1, and none with 0
data modify storage bs.random:binomial in set value {trials:5,probability:1.0}
assert result 5 run compute default integer bs.random:binomial
data modify storage bs.random:binomial in set value {trials:5,probability:0.0}
assert result 0 run compute default integer bs.random:binomial

# More trials than the 1000 of v4: 64 draws of 2000 trials at 0.5 average near 1000
data modify storage bs.random:binomial in set value {trials:2000,probability:0.5}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:binomial
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 62720..65280
