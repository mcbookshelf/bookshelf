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

execute store result score #a bs.ctx run data get storage bs:ctx _.coeffs[0] 1
execute store result score #b bs.ctx run data get storage bs:ctx _.coeffs[1] 1
execute store result score #c bs.ctx run data get storage bs:ctx _.coeffs[2] 1
execute store result score #d bs.ctx run data get storage bs:ctx _.coeffs[3] 1
execute store result score #e bs.ctx run data get storage bs:ctx _.coeffs[4] 1
execute store result score #f bs.ctx run data get storage bs:ctx _.coeffs[5] 1
execute store result score #g bs.ctx run data get storage bs:ctx _.coeffs[6] 1
execute store result score #h bs.ctx run data get storage bs:ctx _.coeffs[7] 1
execute store result score #i bs.ctx run data get storage bs:ctx _.coeffs[8] 1
execute store result score #j bs.ctx run data get storage bs:ctx _.coeffs[9] 1
execute store result score #k bs.ctx run data get storage bs:ctx _.coeffs[10] 1
execute store result score #l bs.ctx run data get storage bs:ctx _.coeffs[11] 1

data modify storage bs:lambda spline.point set value [0d, 0d, 0d]
function bs.spline:stream/stream_3d with storage bs:ctx _
