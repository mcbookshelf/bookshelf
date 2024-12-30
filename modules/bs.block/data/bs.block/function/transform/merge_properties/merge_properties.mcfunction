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

execute if data storage bs:out block{group:0} run return 0

$data modify storage bs:ctx _ set value {i:$(properties)}
function bs.block:transform/lookup_group with storage bs:out block
loot replace block -30000000 0 1606 container.0 loot bs.block:get/get_block
data modify storage bs:ctx _.p set from block -30000000 0 1606 item.components."minecraft:custom_data".properties
function bs.block:transform/merge_properties/recurse/next with storage bs:ctx _.i[-1]
