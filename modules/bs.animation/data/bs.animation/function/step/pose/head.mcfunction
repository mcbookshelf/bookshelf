# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:ctx _ set from storage bs:data animation[-1].def[-1].pose.head
execute if function bs.animation:utils/step/next run data modify storage bs:data animation[-1].def[-1].continue set value 1b
function bs.animation:utils/eval/3d/any with storage bs:ctx _[0]
data modify storage bs:data animation[-1].def[-1].pose.head set from storage bs:ctx _

execute store result storage bs:data animation[-1].nbt.Pose.Head[0] float .001 run scoreboard players get #x bs.ctx
execute store result storage bs:data animation[-1].nbt.Pose.Head[1] float .001 run scoreboard players get #y bs.ctx
execute store result storage bs:data animation[-1].nbt.Pose.Head[2] float .001 run scoreboard players get #z bs.ctx
