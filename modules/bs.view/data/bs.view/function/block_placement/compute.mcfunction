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

execute store result storage bs:ctx x int 1 run data get storage bs:out raycast.hit_normal[0]
execute store result storage bs:ctx y int 1 run data get storage bs:out raycast.hit_normal[1]
execute store result storage bs:ctx z int 1 run data get storage bs:out raycast.hit_normal[2]

function bs.view:block_placement/displace with storage bs:ctx
$execute at @s as @n[tag=bs.view.this,sort=arbitrary] run $(run)
