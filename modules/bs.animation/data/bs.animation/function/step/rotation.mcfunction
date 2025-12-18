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

data modify storage bs:ctx _ set from storage bs:data animation._[-1].rotation
function bs.animation:utils/evaluate/2d/any with storage bs:ctx _[0]
function bs.animation:utils/step/next
data modify storage bs:data animation._[-1].rotation set from storage bs:ctx _

data modify storage bs:data animation.Rotation set value [0f,0f]
execute store result storage bs:data animation.Rotation[0] float .001 run scoreboard players get #x bs.ctx
execute store result storage bs:data animation.Rotation[1] float .001 run scoreboard players get #y bs.ctx
