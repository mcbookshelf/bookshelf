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

execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=0] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,14.2222222,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=1] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,12.4444444,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=2] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,10.6666666,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=3] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,8.8888888,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=4] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,7.1111111,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=5] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,5.3333333,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=6] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,3.5555555,16,2]]}
execute if block ~ ~ ~ #bs.hitbox:is_fluid[level=7] run return run data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,1.7777777,16,2]]}
data modify storage bs:lambda hitbox set value {shape:[[0,0,0,16,14.2222222,16,2]]}
