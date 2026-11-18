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


# The first trial succeeds with a probability of 1
data modify storage bs.random:geometric in set value {probability:1.0}
assert result 1 run compute default integer bs.random:geometric

# 64 draws at 0.25 average near 4
data modify storage bs.random:geometric in set value {probability:0.25}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 146..366

# A low probability can take more than 1000 trials: 64 draws at 0.001 average near 1000
data modify storage bs.random:geometric in set value {probability:0.001}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:geometric
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 32000..96000
