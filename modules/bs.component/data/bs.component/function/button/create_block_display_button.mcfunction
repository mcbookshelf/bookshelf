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

# Create the base properties
$data modify storage bs:ctx _ set value { width: $(width), height: $(height), on_click: "$(on_click)" , block_state: { Name: $(block), Properties: $(properties) }, Tags: ["bs.component.block_display", "smithed.entity", "smithed.strict"], transformation: { translation: [-0.5f, 0.5f, -0.5f]}, with: {}}
$data modify storage bs:ctx _ merge value $(with)
data modify storage bs:ctx _.with.hover set from storage bs:ctx _.hover
data modify storage bs:ctx _.with.hover_leave set from storage bs:ctx _.hover_leave

# Summon the item display
execute summon block_display run data modify entity @s {} merge from storage bs:ctx _

# Create the button at the block display's position
execute as @n[tag=bs.component.block_display] at @s anchored feet positioned ^ ^ ^ run function bs.component:button/create_simple_button with storage bs:ctx _
tag @n[tag=bs.component.block_display] remove bs.component.block_display
