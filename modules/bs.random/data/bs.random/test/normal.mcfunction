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

# A spread of 0 gives the mean as is
data modify storage bs.random:normal in set value {mean:-2.6,spread:0.0}
data modify storage bs.random:test v set compute default float bs.random:normal
assert result -2600 run data get storage bs.random:test v 1000

# 64 draws average near the mean
data modify storage bs.random:normal in set value {mean:1000.0,spread:300.0}
scoreboard players set #t bs.ctx 0
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
execute store result score #n bs.ctx run compute default float bs.random:normal
scoreboard players operation #t bs.ctx += #n bs.ctx
assert score #t bs.ctx matches 54400..73600

# A spread below 1 still spreads the results, at most 6 spreads from the mean
data modify storage bs.random:normal in set value {mean:10.0,spread:0.01}
data modify storage bs.random:test v set compute default float bs.random:normal
execute store result score #0 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:normal
execute store result score #1 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:normal
execute store result score #2 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:normal
execute store result score #3 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:normal
execute store result score #4 bs.ctx run data get storage bs.random:test v 1000000
assert score #0 bs.ctx matches 9940000..10060000
assert score #1 bs.ctx matches 9940000..10060000
assert score #2 bs.ctx matches 9940000..10060000
assert score #3 bs.ctx matches 9940000..10060000
assert score #4 bs.ctx matches 9940000..10060000
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "normal should not always give the same value"
