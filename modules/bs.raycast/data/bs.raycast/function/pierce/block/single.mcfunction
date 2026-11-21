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

execute store result score #raycast.next bs.data store result score #raycast.block bs.data store result score #raycast.bhit bs.data run compute default integer bs.raycast:_pierce/b/near
execute if data storage bs.raycast: ray.on_exit store result score #raycast.end0 bs.data run compute default integer bs.raycast:_pierce/b/exit
scoreboard players operation #raycast.next bs.data < #raycast.entity bs.data
scoreboard players operation #raycast.next bs.data /= 64 bs.const
return 1
