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




tp B5-0-0-0-1 ~ ~ ~

data modify storage bs.screen_detection:data Pos set from entity B5-0-0-0-1 Pos
execute store result score #v0 bs.ctx run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #v1 bs.ctx run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #v2 bs.ctx run data get storage bs.screen_detection:data Pos[2] 1000


execute positioned .0 .0 .0 run tp B5-0-0-0-1 ^ ^ ^1
data modify storage bs.screen_detection:data Pos set from entity B5-0-0-0-1 Pos
execute store result score #u0 bs.ctx run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #u1 bs.ctx run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #u2 bs.ctx run data get storage bs.screen_detection:data Pos[2] 1000

tp B5-0-0-0-1 -30000000 1000 1600
