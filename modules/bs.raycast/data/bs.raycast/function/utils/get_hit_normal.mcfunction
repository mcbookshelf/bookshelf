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

execute if score $raycast.hit_face bs.lambda matches 5 run data modify storage bs:lambda raycast.hit_normal set value [1,0,0]
execute if score $raycast.hit_face bs.lambda matches 4 run data modify storage bs:lambda raycast.hit_normal set value [-1,0,0]
execute if score $raycast.hit_face bs.lambda matches 3 run data modify storage bs:lambda raycast.hit_normal set value [0,0,1]
execute if score $raycast.hit_face bs.lambda matches 2 run data modify storage bs:lambda raycast.hit_normal set value [0,0,-1]
execute if score $raycast.hit_face bs.lambda matches 1 run data modify storage bs:lambda raycast.hit_normal set value [0,1,0]
execute if score $raycast.hit_face bs.lambda matches 0 run data modify storage bs:lambda raycast.hit_normal set value [0,-1,0]
