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

# Add input points and base max_health
execute store result storage bs.health: points float 0.000001 run attribute @s minecraft:max_health base get 1000000
data modify storage bs.health: points set compute default float {type:"add",inputs:[{type:"storage",storage:"bs.health:add_max_health",path:"in.points"},{type:"storage",storage:"bs.health:",path:"points"}]}
function bs.health:add_max_health/run with storage bs.health:
