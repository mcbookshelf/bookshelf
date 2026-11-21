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

execute unless score #raycast.bhit bs.data matches 2147483647 if data storage bs.raycast: ray.on_block unless function bs.raycast:pierce/block/on_block run return fail
execute if data storage bs.raycast: ray.on_entry unless function bs.raycast:pierce/block/on_entry run return fail
execute if data storage bs.raycast: ray.on_exit unless function bs.raycast:pierce/block/on_exit run return fail
execute store result score #raycast.next bs.data store result score #raycast.block bs.data run compute default integer bs.raycast:_pierce/b/next
return 1
