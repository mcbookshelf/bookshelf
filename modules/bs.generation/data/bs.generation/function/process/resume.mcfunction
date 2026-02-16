# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

data remove storage bs:data generation[-1]._
data modify entity @s Pos set from storage bs:data generation[-1].pos
$execute at @s in $(dim) run function $(psr) with storage bs:data generation[-1]

data remove storage bs:data generation[-1]
execute if data storage bs:data generation[-1]._ run return run function bs.generation:process/resume with storage bs:data generation[-1]
tp @s -30000000 0 1600
