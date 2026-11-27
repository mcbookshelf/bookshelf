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

# The result stays in the range
data modify storage bs.random:uniform in set value {min:-3,max:3}
assert result -3..3 run compute default integer bs.random:uniform
data modify storage bs.random:uniform in set value {min:7,max:7}
assert result 7 run compute default integer bs.random:uniform

# It does not give the same value each time
data modify storage bs.random:uniform in set value {min:-10000000,max:10000000}
execute store result score #0 bs.ctx run compute default integer bs.random:uniform
execute store result score #1 bs.ctx run compute default integer bs.random:uniform
execute store result score #2 bs.ctx run compute default integer bs.random:uniform
execute store result score #3 bs.ctx run compute default integer bs.random:uniform
execute store result score #4 bs.ctx run compute default integer bs.random:uniform
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "uniform should not always give the same value"

# The float provider stays in the range, and gives fractions
data modify storage bs.random:uniform in set value {min:2.25,max:2.75}
data modify storage bs.random:test v set compute default float bs.random:uniform
assert result 2250..2750 run data get storage bs.random:test v 1000
data modify storage bs.random:uniform in set value {min:-0.5,max:-0.5}
data modify storage bs.random:test v set compute default float bs.random:uniform
assert result -500 run data get storage bs.random:test v 1000

# It does not give the same value each time
data modify storage bs.random:uniform in set value {min:0.0,max:1.0}
data modify storage bs.random:test v set compute default float bs.random:uniform
execute store result score #0 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:uniform
execute store result score #1 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:uniform
execute store result score #2 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:uniform
execute store result score #3 bs.ctx run data get storage bs.random:test v 1000000
data modify storage bs.random:test v set compute default float bs.random:uniform
execute store result score #4 bs.ctx run data get storage bs.random:test v 1000000
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "uniform should not always give the same fraction"

# Each provider takes any number: the integer one drops the fractions
data modify storage bs.random:uniform in set value {min:7,max:7}
data modify storage bs.random:test v set compute default float bs.random:uniform
assert result 7000 run data get storage bs.random:test v 1000
data modify storage bs.random:uniform in set value {min:2.9,max:2.9}
assert result 2 run compute default integer bs.random:uniform
