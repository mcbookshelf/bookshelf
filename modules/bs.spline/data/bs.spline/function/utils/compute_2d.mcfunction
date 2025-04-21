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

# Apply negative scaling to round up the result and reduce precision loss from floored coefficients
scoreboard players operation #x bs.ctx *= #d bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
scoreboard players operation #x bs.ctx -= #c bs.ctx
scoreboard players operation #x bs.ctx *= #t bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
scoreboard players operation #x bs.ctx += #b bs.ctx
scoreboard players operation #x bs.ctx *= #t bs.ctx
scoreboard players operation #x bs.ctx /= -1000 bs.const
execute store result storage bs:lambda spline.point[0] double -.001 run scoreboard players operation #x bs.ctx -= #a bs.ctx

scoreboard players operation #y bs.ctx *= #h bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
scoreboard players operation #y bs.ctx -= #g bs.ctx
scoreboard players operation #y bs.ctx *= #t bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
scoreboard players operation #y bs.ctx += #f bs.ctx
scoreboard players operation #y bs.ctx *= #t bs.ctx
scoreboard players operation #y bs.ctx /= -1000 bs.const
execute store result storage bs:lambda spline.point[1] double -.001 run scoreboard players operation #y bs.ctx -= #e bs.ctx
