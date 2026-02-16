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

data remove storage bs:data generation[-1].block
$execute in minecraft:overworld run loot replace block -30000000 0 1606 contents loot $(blocks)
execute in minecraft:overworld run data modify storage bs:data generation[-1] merge from block -30000000 0 1606 item.components."minecraft:custom_data"
execute unless data storage bs:data generation[-1].block run return run function bs.generation:utils/block/set_type
function bs.generation:utils/block/set_block with storage bs:data generation[-1]
