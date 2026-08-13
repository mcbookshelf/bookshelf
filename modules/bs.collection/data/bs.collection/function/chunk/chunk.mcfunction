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

execute store result score #l bs.ctx run data get storage bs:out collection.value
execute if score #l bs.ctx matches 0 run return 0

$scoreboard players set #n bs.ctx $(size)
data modify storage bs:ctx _ set from storage bs:out collection.value
data modify storage bs:out collection set value { value: [] }
execute if score #l bs.ctx > #n bs.ctx run return run function bs.collection:chunk/chunk_rec
data modify storage bs:out collection.value append from storage bs:ctx _
