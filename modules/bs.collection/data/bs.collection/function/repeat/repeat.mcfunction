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

# Check for error condition count < 0
$scoreboard players set #c bs.ctx $(count)
$data modify storage bs:ctx _ set value $(value)
execute if score #c bs.ctx matches ..-1 run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:repeat/repeat", tag: "repeat", message: '"Count must be positive"'}
execute if score #c bs.ctx matches ..-1 run return fail

data modify storage bs:out collection.value set value []
function bs.collection:repeat/repeat_rec
