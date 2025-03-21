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

data modify storage bs:data generation._ set from storage bs:data generation.shape_2d[-1]
data remove storage bs:data generation._._

$function bs.generation:shape_2d/strategy/$(impl)/setup
data modify entity @s Pos set from storage bs:data generation._.pos
data modify entity @s Rotation set from storage bs:data generation._.rot
$execute in $(dim) positioned as @s rotated as @s run function bs.generation:shape_2d/recurse/next with storage bs:data generation._

data remove storage bs:data generation.shape_2d[-1]
execute if data storage bs:data generation.shape_2d[-1]._ \
  run return run function bs.generation:shape_2d/process/resume with storage bs:data generation.shape_2d[-1]

execute in minecraft:overworld run tp @s -30000000 0 1600
