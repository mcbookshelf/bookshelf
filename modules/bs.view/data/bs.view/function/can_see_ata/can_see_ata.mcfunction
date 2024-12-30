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

data modify storage bs:ctx _ set from entity @s Pos
data modify storage bs:ctx x set from storage bs:ctx _[0]
data modify storage bs:ctx y set from storage bs:ctx _[1]
data modify storage bs:ctx z set from storage bs:ctx _[2]
execute summon minecraft:marker run function bs.view:can_see_ata/max_distance/get_rpos with storage bs:ctx
function bs.view:can_see_ata/max_distance/compute with storage bs:ctx

execute facing entity @s eyes run function bs.raycast:run
return run execute if score #raycast.distance bs.data matches 2147483647
