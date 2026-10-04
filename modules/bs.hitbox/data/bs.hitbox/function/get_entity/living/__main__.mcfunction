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

execute store result storage bs.hitbox: i int 1 store result score #d bs.ctx run compute entity @s integer {type:"conditional",condition:"bs.hitbox:get_entity/living",on_true:"bs.hitbox:_get_entity/dimensions",on_false:0}
execute unless score #d bs.ctx matches 0..32767 run return run function bs.hitbox:get_entity/unpack
execute if score #d bs.ctx matches 1..32767 run return run function bs.hitbox:get_entity/dispatch with storage bs.hitbox:
return 0
