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

data modify storage bs:ctx _ set from entity @s Pos
execute store result storage bs:ctx x int -1 run data get storage bs:ctx _[0]
execute store result storage bs:ctx y int -1 run data get storage bs:ctx _[1]
execute store result storage bs:ctx z int -1 run data get storage bs:ctx _[2]
function bs.hitbox:utils/get_relative_pos with storage bs:ctx
