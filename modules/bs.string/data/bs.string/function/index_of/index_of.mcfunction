# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#index-of
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:ctx _.str set from storage bs:in string.index_of.str
data modify storage bs:data string.current set from storage bs:in string.index_of.str 
$data modify storage bs:data string.caracter set value $(char)
$scoreboard players set #string.occurence bs.data $(occurence)
function bs.string:index_of/lenth
scoreboard players set #c bs.ctx 0
function bs.string:index_of/recurcive_search
return run scoreboard players operation $string.index_of bs.out = #c bs.ctx