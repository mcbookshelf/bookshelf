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

$scoreboard players set #m bs.ctx $(min)
$scoreboard players set #n bs.ctx $(max)
$scoreboard players set #s bs.ctx $(step)

# Check for error condition min >= max
execute if score #m bs.ctx >= #n bs.ctx run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:range/range", tag: "range", message: '"Min must be strictly lower than max"'}
execute if score #m bs.ctx >= #n bs.ctx run return fail

data modify storage bs:out collection.value set value []
function bs.collection:range/range_rec
