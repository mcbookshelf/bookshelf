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

data remove storage bs:data spline.stream[-1]._
data modify storage bs:ctx _ set from storage bs:data spline.stream[-1]

execute store result score #s bs.ctx run data get storage bs:ctx _.step 1000
execute store result score #t bs.ctx run data get storage bs:ctx _.time

execute store result score #i bs.ctx if data storage bs:ctx _.coeffs[]
execute if score #i bs.ctx matches 4 run function bs.spline:stream/process/resume_1d
execute if score #i bs.ctx matches 8 run function bs.spline:stream/process/resume_2d
execute if score #i bs.ctx matches 12 run function bs.spline:stream/process/resume_3d

data remove storage bs:data spline.stream[-1]
execute if data storage bs:data spline.stream[-1]._ run function bs.spline:stream/process/resume
