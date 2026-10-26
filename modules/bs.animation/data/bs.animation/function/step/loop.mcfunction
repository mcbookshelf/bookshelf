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

function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
$$(run)
data modify storage bs.animation: stack[-1].nbt.data."bs.animation" append from storage bs.animation: stack[-1]._[0]
data remove storage bs.animation: stack[-1]._[0]
execute if data storage bs.animation: stack[-1]._[0] run function bs.animation:step/loop with storage bs.animation: stack[-1]._[0]
