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

data modify storage bs:ctx _ set from storage bs:in spline.sample_bezier
execute store result score #s bs.ctx run data get storage bs:ctx _.step 1000
execute store result storage bs:ctx x int 1 run scoreboard players set #t bs.ctx 0
function bs.spline:sample/sample { type: "bezier" }
data modify storage bs:out spline.sample_bezier set from storage bs:ctx _.sout
