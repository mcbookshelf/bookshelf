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

$execute store success score #s bs.ctx run data modify storage bs:ctx _.i[-1].v set from storage bs:ctx _.p."$(name)"
execute if score #s bs.ctx matches 1 run function bs.block:transform/merge_properties/recurse/get_by_value with storage bs:ctx _.i[-1]

data modify storage bs:out block.properties merge from storage bs:ctx _.v.p
data modify storage bs:out block._ merge from storage bs:ctx _.v.s

data remove storage bs:ctx _.i[-1]
function bs.block:transform/merge_properties/recurse/next with storage bs:ctx _.i[-1]
