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

scoreboard players reset @s bs.link.to
scoreboard players reset @s bs.link.rx
scoreboard players reset @s bs.link.ry
scoreboard players reset @s bs.link.rz
scoreboard players reset @s bs.link.lx
scoreboard players reset @s bs.link.ly
scoreboard players reset @s bs.link.lz
scoreboard players reset @s bs.link.lh
scoreboard players reset @s bs.link.lv

scoreboard players operation $link.to bs.in = @s bs.id
execute if predicate bs.id:has_suid as @e[predicate=bs.link:link_equal] run function #bs.link:remove_link
