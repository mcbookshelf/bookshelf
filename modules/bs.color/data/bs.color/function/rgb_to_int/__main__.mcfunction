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

$data modify storage bs.color: color set value $(color)

data modify storage bs.color:rgb_to_int out set compute default integer {type:"add",inputs:[{type:"mul",inputs:[65536,{type:"storage",storage:"bs.color:",path:"color[0]"}]},{type:"mul",inputs:[256,{type:"storage",storage:"bs.color:",path:"color[1]"}]},{type:"storage",storage:"bs.color:",path:"color[2]"}]}

execute unless data storage bs.color: color[3] run return 1

execute store result score #c bs.ctx run data get storage bs.color:rgb_to_int out
execute store result score #a bs.ctx run data get storage bs.color: color[3]
scoreboard players operation #a bs.ctx *= 16777216 bs.const
execute store result storage bs.color:rgb_to_int out int 1 run scoreboard players operation #c bs.ctx += #a bs.ctx

return run data get storage bs.color:rgb_to_int out
