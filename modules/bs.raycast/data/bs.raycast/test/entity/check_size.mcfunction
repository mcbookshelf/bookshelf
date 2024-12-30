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

summon minecraft:armor_stand ~.5 ~ ~.5
execute positioned ~1.5 ~1 ~.5 facing ~-.76 ~ ~.24 run function #bs.raycast:run {with:{blocks:false,entities:true}}
execute unless data storage bs:out raycast.targeted_entity run fail "Failed to detect a targeted entity"
execute positioned ~-.5 ~1 ~.5 facing ~.76 ~ ~-.24 run function #bs.raycast:run {with:{blocks:false,entities:true}}
execute unless data storage bs:out raycast.targeted_entity run fail "Failed to detect a targeted entity"
