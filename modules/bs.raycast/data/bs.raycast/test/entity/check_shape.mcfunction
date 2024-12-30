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

summon minecraft:item_frame ~ ~ ~ {Facing:0}
execute positioned ~.5 ~.5 ~.5 facing ~ ~1 ~ run function #bs.raycast:run {with:{blocks:false,entities:true}}
execute unless data storage bs:out raycast.targeted_entity run fail "Failed to detect a targeted entity"

summon minecraft:item_frame ~ ~ ~ {Facing:1}
execute positioned ~.5 ~.5 ~.5 facing ~ ~-1 ~ run function #bs.raycast:run {with:{blocks:false,entities:true}}
execute unless data storage bs:out raycast.targeted_entity run fail "Failed to detect a targeted entity"
