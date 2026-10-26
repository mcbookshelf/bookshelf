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

execute unless block ~ ~ ~ #bs.hitbox:_get_block/interaction run return run function bs.hitbox:get_block/outline_with_fluid/__main__
function bs.hitbox:get_block/outline_with_fluid/__main__
execute if block ~ ~ ~ #minecraft:cauldrons run return run data modify storage bs.hitbox:get_block out append value [0.,.1875,0.,1.,1.,1.,4.]
execute if block ~ ~ ~ minecraft:hopper run return run data modify storage bs.hitbox:get_block out append value [0.,.625,0.,1.,1.,1.,4.]
return run data modify storage bs.hitbox:get_block out append value [0.,0.,0.,1.,1.,1.,4.]
