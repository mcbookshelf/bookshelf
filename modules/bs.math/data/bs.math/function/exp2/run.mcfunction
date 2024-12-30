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

# exp2(x) = exp2(i) * exp2(f)
scoreboard players operation #e bs.ctx /= 16777216 bs.const
execute store result storage bs:ctx x float .000000059604644775390625 run scoreboard players operation #x bs.ctx %= 16777216 bs.const
execute unless score #x bs.ctx matches 0 run function bs.math:exp2/fract with storage bs:ctx
execute if score #x bs.ctx matches 0 run data modify storage bs:ctx x set value 1.0
function bs.math:ldexp/run with storage bs:ctx
