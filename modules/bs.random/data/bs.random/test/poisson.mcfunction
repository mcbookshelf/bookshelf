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


# No event happens with a lambda of 0
data modify storage bs.random:poisson in set value {lambda:0.0}
assert result 0 run compute default integer bs.random:poisson

# 64 draws average near lambda
data modify storage bs.random:poisson in set value {lambda:5.0}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 243..397
data modify storage bs.random:poisson in set value {lambda:0.3}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default integer bs.random:poisson
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 4..45

# It does not give the same value each time
data modify storage bs.random:poisson in set value {lambda:7.5}
execute store result score #0 bs.ctx run compute default integer bs.random:poisson
execute store result score #1 bs.ctx run compute default integer bs.random:poisson
execute store result score #2 bs.ctx run compute default integer bs.random:poisson
execute store result score #3 bs.ctx run compute default integer bs.random:poisson
execute store result score #4 bs.ctx run compute default integer bs.random:poisson
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "poisson should not always give the same value"

# Every step of lambda gives a count
data modify storage bs.random:poisson in.lambda set value 0.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 0.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 1.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 2.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 3.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 4.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 5.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 6.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 7.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 8.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.0
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.1
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.2
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.3
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.4
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.5
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.6
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.7
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.8
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 9.9
assert result 0..40 run compute default integer bs.random:poisson
data modify storage bs.random:poisson in.lambda set value 10.0
assert result 0..40 run compute default integer bs.random:poisson
