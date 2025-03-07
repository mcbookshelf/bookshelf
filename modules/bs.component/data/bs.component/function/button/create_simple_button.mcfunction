# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

tag @s add bs.component.icon
$data modify storage bs.ctx _ set value { width: $(width), height: $(height), on_click: "$(on_click)", hover: "function #bs.interaction:callback/glow", hover_leave: "function #bs.interaction:callback/unglow" }
data modify storage bs.ctx _.hover set from storage bs.ctx _.with.hover
data modify storage bs.ctx _.hover_leave set from storage bs.ctx _.with.hover_leave
execute summon minecraft:interaction run function bs.component:button/setup_button with storage bs.ctx _
tag @s remove bs.component.icon
