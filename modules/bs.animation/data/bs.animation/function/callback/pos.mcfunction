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

data modify storage bs:data animation[-1].nbt.Pos set value [0d,0d,0d]
execute store result storage bs:data animation[-1].nbt.Pos[0] double .001 run scoreboard players get $animation.x bs.lambda
execute store result storage bs:data animation[-1].nbt.Pos[1] double .001 run scoreboard players get $animation.y bs.lambda
execute store result storage bs:data animation[-1].nbt.Pos[2] double .001 run scoreboard players get $animation.z bs.lambda
