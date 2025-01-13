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

data modify storage bs:ctx _.str set from storage bs:in string.index_of.str
data modify storage bs:data string.current set from storage bs:in string.index_of.str 
$data modify storage bs:data string.caracter set value $(char)
$scoreboard players set #string.occurence bs.data $(occurence)
execute store result score #n bs.data run data get storage bs:data string.current
scoreboard players set #c bs.ctx 0
function bs.string:index_of/recursive_search
return run scoreboard players operation $string.index_of bs.out = #c bs.ctx
