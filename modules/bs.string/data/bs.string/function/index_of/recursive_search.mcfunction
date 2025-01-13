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

data modify storage bs:ctx _.char set from storage bs:data string.caracter
execute if score #c bs.ctx >= #string.lenth bs.data run return run scoreboard players set #c bs.ctx -1
execute unless function bs.string:index_of/test_caracter run scoreboard players add #o bs.ctx 1
execute if score #o bs.ctx = #string.occurence bs.data run return run scoreboard players get #c bs.ctx
scoreboard players add #c bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1
function bs.string:index_of/recurcive_search
