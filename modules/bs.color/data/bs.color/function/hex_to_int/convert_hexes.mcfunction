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

$execute store result score $color.hex_to_int bs.out run data get storage bs:const color.hex_values.$(z)
$execute store result score #r bs.ctx run data get storage bs:const color.hex_values.$(y)
scoreboard players operation #r bs.ctx *= 256 bs.const
scoreboard players operation $color.hex_to_int bs.out += #r bs.ctx
$execute store result score #r bs.ctx run data get storage bs:const color.hex_values.$(x)
scoreboard players operation #r bs.ctx *= 65536 bs.const
execute store result storage bs:out color.hex_to_int int 1 run return run scoreboard players operation $color.hex_to_int bs.out += #r bs.ctx
