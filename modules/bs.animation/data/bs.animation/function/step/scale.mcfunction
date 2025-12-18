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

data modify storage bs:ctx _ set from storage bs:data animation._[-1].scale
function bs.animation:utils/evaluate/1d/any with storage bs:ctx _[0]
function bs.animation:utils/step/next
data modify storage bs:data animation._[-1].scale set from storage bs:ctx _

attribute @s minecraft:scale modifier remove bs:animation
execute store result score #y bs.ctx run attribute @s minecraft:scale get 1000
execute store result storage bs:ctx x double .001 run scoreboard players operation #x bs.ctx -= #y bs.ctx
function bs.animation:utils/scale with storage bs:ctx
