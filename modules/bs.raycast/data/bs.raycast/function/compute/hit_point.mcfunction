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

data modify entity @s Pos set from storage bs:data raycast.pos
$execute positioned as @s run tp @s ^ ^ ^$(distance)
data modify storage bs:out raycast.hit_point set from entity @s Pos
execute if data storage bs:data raycast.on_hit_point at @s run function bs.raycast:react/hit_point with storage bs:data raycast
kill @s
