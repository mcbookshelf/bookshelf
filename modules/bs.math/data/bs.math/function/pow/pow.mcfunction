# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
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

# pow(x,y) = exp2(y * log2(x))
data modify storage bs:ctx x set from storage bs:in math.pow.x
data modify storage bs:ctx y set from storage bs:in math.pow.y

function bs.math:frexp/run
function bs.math:log2/fract with storage bs:ctx
scoreboard players operation #e bs.ctx *= 16777216 bs.const
function bs.math:pow/mul with storage bs:ctx

execute store result score #e bs.ctx store result score #x bs.ctx run data get storage bs:ctx x
function bs.math:exp2/run
data modify storage bs:out math.pow set from storage bs:ctx x
