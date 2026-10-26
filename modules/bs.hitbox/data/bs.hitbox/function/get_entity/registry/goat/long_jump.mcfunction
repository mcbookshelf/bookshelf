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

# A goat whose box no longer reaches its height is long jumping: its height, and the scale of its width, by 0.7
$execute at @s positioned ~ ~$(i) ~ positioned ~ ~-.001 ~ if entity @s[dx=0] run return 0
data modify storage bs.hitbox:get_entity out[0][4] set compute default float {type:"mul",inputs:[{type:"storage",storage:"bs.hitbox:get_entity",path:"out[0][4]"},0.7]}
execute store result score #s bs.ctx run compute default integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"from_int",input:{type:"score",target:{type:"fixed",name:"#s"},score:"bs.ctx"}},0.7]}}}
