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

data modify storage bs:lambda spline.point set value [0d]
execute store result score #x bs.ctx run scoreboard players operation #t bs.ctx %= 1000 bs.const

execute store result score #a bs.ctx run data get storage bs:ctx _.points[0][0] 1000
execute store result score #b bs.ctx run data get storage bs:ctx _.points[1][0] 1000

# Compute Lerp coefficients
execute store result score #c bs.ctx run scoreboard players set #d bs.ctx 0
scoreboard players operation #b bs.ctx -= #a bs.ctx

data remove storage bs:ctx _.points[0]
