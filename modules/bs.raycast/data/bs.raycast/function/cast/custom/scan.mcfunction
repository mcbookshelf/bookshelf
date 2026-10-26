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

$execute positioned ^ ^ ^$(_middle) as @e[tag=bs.hitbox.unbounded,tag=!bs.raycast.omit,distance=..$(_reach),$(selector)] positioned ^4096 ^ ^ if entity @s[distance=..4112] positioned ^-8192 ^ ^ if entity @s[distance=..4112] positioned ^4096 ^4096 ^ if entity @s[distance=..4112] positioned ^ ^-8192 ^ if entity @s[distance=..4112] if function bs.raycast:cast/entity/check if score @s bs.raycast.hit = #raycast.entity bs.data if score #raycast.entity bs.data <= #raycast.block bs.data run function bs.raycast:cast/entity/emit
