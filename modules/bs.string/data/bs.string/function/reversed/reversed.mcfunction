# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:ctx _.str set from storage bs:in string.reversed.str
scoreboard players set #i bs.ctx 0
execute store result score #l bs.ctx run data get storage bs:in string.reversed.str

execute if score #l bs.ctx matches ..1 run return run data modify storage bs:out string.reversed set from storage bs:in string.reversed.str

function bs.string:reversed/loop

function bs.string:concat/run

data modify storage bs:out string.reversed set from storage bs:ctx _.s.1

return run scoreboard players get #l bs.ctx
