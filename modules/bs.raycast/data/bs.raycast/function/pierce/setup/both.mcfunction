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

data modify storage bs.raycast: ray._predicate set string storage bs.raycast: ray.entities 1
execute unless data storage bs.raycast: ray.on_entry unless data storage bs.raycast: ray.on_exit run data modify storage bs.raycast: ray._block set value "bs.raycast:pierce/block/only/check"
$execute align xyz run function bs.raycast:step/builtin/both/$(_octant)/init with storage bs.raycast: ray
function bs.raycast:utils/untag with storage bs.raycast: ray
tp @s ~ -1000000 ~
kill @s
