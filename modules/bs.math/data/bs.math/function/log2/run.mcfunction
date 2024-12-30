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

# decompose x into a normalized fraction and an integral power of two [log2(x) = log2(frexp.x) + frexp.e]
function bs.math:frexp/run
function bs.math:log2/fract with storage bs:ctx
scoreboard players operation #e bs.ctx *= 16777216 bs.const
execute store result storage bs:ctx x float .000000059604644775390625 run scoreboard players operation #x bs.ctx += #e bs.ctx
