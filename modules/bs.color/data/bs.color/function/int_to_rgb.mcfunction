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

$scoreboard players set #c bs.ctx $(color)

scoreboard players operation $color.int_to_rgb.r bs.out = #c bs.ctx
scoreboard players operation $color.int_to_rgb.r bs.out /= 65536 bs.const
scoreboard players operation $color.int_to_rgb.g bs.out = #c bs.ctx
scoreboard players operation $color.int_to_rgb.g bs.out /= 256 bs.const
scoreboard players operation $color.int_to_rgb.b bs.out = #c bs.ctx

execute store result storage bs:out color.int_to_rgb[0] int 1 run scoreboard players operation $color.int_to_rgb.r bs.out %= 256 bs.const
execute store result storage bs:out color.int_to_rgb[1] int 1 run scoreboard players operation $color.int_to_rgb.g bs.out %= 256 bs.const
execute store result storage bs:out color.int_to_rgb[2] int 1 run scoreboard players operation $color.int_to_rgb.b bs.out %= 256 bs.const
