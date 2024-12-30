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

$data modify storage bs:ctx _ set value $(color)

execute store result score #r bs.ctx run data get storage bs:ctx _[0]
execute store result score #g bs.ctx run data get storage bs:ctx _[1]
execute store result score #b bs.ctx run data get storage bs:ctx _[2]

scoreboard players operation $color.rgb_to_int bs.out = #r bs.ctx
scoreboard players operation $color.rgb_to_int bs.out *= 65536 bs.const
scoreboard players operation #c bs.ctx = #g bs.ctx
scoreboard players operation #c bs.ctx *= 256 bs.const
scoreboard players operation $color.rgb_to_int bs.out += #c bs.ctx
return run execute store result storage bs:out color.rgb_to_int int 1 run scoreboard players operation $color.rgb_to_int bs.out += #b bs.ctx
