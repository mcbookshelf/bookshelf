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

data modify storage bs.raycast: ray._block set value "bs.raycast:cast/block/hit"
execute unless data storage bs.raycast: ray.on_block unless data storage bs.raycast: ray.on_entry run data modify storage bs.raycast: ray._block set value "bs.raycast:cast/block/stop"
$execute align xyz run function bs.raycast:step/block/$(_octant)/init with storage bs.raycast: ray
tp @s ~ -1000000 ~
kill @s
