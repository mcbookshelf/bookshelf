# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:data view.block_placement.x set from storage bs:lambda raycast.hit_normal[0]
data modify storage bs:data view.block_placement.y set from storage bs:lambda raycast.hit_normal[1]
data modify storage bs:data view.block_placement.z set from storage bs:lambda raycast.hit_normal[2]

execute as @n[tag=bs.view.this,sort=arbitrary] run function bs.view:block_placement/run with storage bs:data view.block_placement
