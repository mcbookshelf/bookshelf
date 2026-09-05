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


# This function runs when instant_health is applied (just after being removed)
execute unless score @s bs.hmod matches 1.. run return 0
scoreboard players operation @s bs.hmod += @s bs.hval


# Get add_multiplied_total to reduce health to the target value, it's applied last, so it won't mess with other modifiers
data modify storage bs:ctx m set from entity @s attributes[{id:"minecraft:max_health"}].base
data modify storage bs:ctx y set compute entity @s float {\
    type:"add",\
    inputs:[\
        -1f,\
        {\
            type:"div",\
            left:{\
                type:"mul",\
                inputs:[\
                    1e-5f,\
                    {type:"from_int",input:{type:"score",target:"this",score:"bs.hmod"}}\
                ]\
            },\
            right:{type:"storage",path:"m",storage:"bs:ctx"}\
        }\
    ]\
}

function bs.health:utils/apply_health with storage bs:ctx
