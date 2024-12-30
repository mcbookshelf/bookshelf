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

$execute store success score #s bs.ctx run data modify storage bs:ctx _.i[-1].v set from storage bs:out block.properties."$(name)"
execute if score #s bs.ctx matches 0 run function bs.block:transform/keep_properties/recurse/get_default with storage bs:ctx _.i[-1]
execute if score #s bs.ctx matches 1 run function bs.block:transform/keep_properties/recurse/get_by_value with storage bs:ctx _.i[-1]

data modify storage bs:ctx _.p merge from storage bs:ctx _.v.p
data modify storage bs:ctx _.s merge from storage bs:ctx _.v.s

data remove storage bs:ctx _.i[-1]
function bs.block:transform/keep_properties/recurse/next with storage bs:ctx _.i[-1]
