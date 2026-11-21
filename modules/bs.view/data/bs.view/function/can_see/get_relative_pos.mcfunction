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

data modify storage bs.view: pos set from entity @s Pos
data modify storage bs.view: x set from storage bs.view: pos[0]
data modify storage bs.view: y set from storage bs.view: pos[1]
data modify storage bs.view: z set from storage bs.view: pos[2]
function bs.view:can_see/move_relative with storage bs.view:
data modify storage bs.view: rel set from entity @s Pos
tp @s ~ -1000000 ~
kill @s
