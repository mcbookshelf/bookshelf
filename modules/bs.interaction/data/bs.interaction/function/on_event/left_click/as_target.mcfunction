# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

tag @s add bs.interaction.target
data remove entity @s attack
data modify storage bs:data interaction set value []
data modify storage bs:data interaction append from entity @s data."bs.interaction".events[{type:"left_click"}]
execute if data storage bs:data interaction[-1] run function bs.interaction:on_event/run with storage bs:data interaction[-1]
tag @s remove bs.interaction.target
