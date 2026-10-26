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

execute store result score #raycast.next bs.data run scoreboard players operation #raycast.entity bs.data = @s bs.raycast.hit
scoreboard players operation #raycast.next bs.data < #raycast.block bs.data
scoreboard players operation #raycast.next bs.data /= 64 bs.const
return run function bs.raycast:pierce/entity/react
