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

# minecraft:painting
data modify storage bs.hitbox:get_entity out set value [[-.03125f,0f,-.03125f,.03125f,0f,.03125f]]
execute at @s rotated 0 -90 store result storage bs.hitbox:get_entity out[0][1] float -.5 store result storage bs.hitbox:get_entity out[0][4] float .5 run function bs.hitbox:get_entity/registry/painting/8
execute at @s positioned ~.25 ~ ~ if entity @s[dx=0] at @s rotated -90 0 store result storage bs.hitbox:get_entity out[0][0] float -.5 store result storage bs.hitbox:get_entity out[0][3] float .5 run function bs.hitbox:get_entity/registry/painting/8
execute at @s positioned ~.25 ~ ~ unless entity @s[dx=0] at @s rotated 0 0 store result storage bs.hitbox:get_entity out[0][2] float -.5 store result storage bs.hitbox:get_entity out[0][5] float .5 run function bs.hitbox:get_entity/registry/painting/8
return 1
