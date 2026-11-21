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

execute if data storage bs.raycast: ray.on_block run function bs.raycast:utils/on_block with storage bs.raycast: ray
execute if data storage bs.raycast: ray.on_entry at @s run function bs.raycast:utils/at_entry with storage bs.raycast: ray
scoreboard players set #raycast.max bs.data -2147483648
