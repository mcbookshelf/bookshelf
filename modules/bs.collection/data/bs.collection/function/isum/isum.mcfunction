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


data modify storage bs:ctx _ set from storage bs:out collection.value
# Initialize sum to 0
data modify storage bs:out collection.value set value 0
execute unless data storage bs:ctx _[0] run return 0

scoreboard players set #s bs.ctx 0
function bs.collection:isum/isum_rec

execute store result storage bs:out collection.value int 1 run scoreboard players get #s bs.ctx
return run scoreboard players get #s bs.ctx
