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

scoreboard players operation #move.y bs.data = #move.ry bs.data
$function bs.move:collision/recurse/$(sy) with storage bs:data move

scoreboard players remove #move.x bs.data 10000000
execute if score #move.x bs.data >= #move.nx bs.data positioned ~-1 ~ ~ run function bs.move:collision/recurse/xn with storage bs:data move
