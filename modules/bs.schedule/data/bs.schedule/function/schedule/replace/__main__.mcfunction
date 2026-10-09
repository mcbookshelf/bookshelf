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

data modify storage bs.schedule: e set from storage bs.schedule:schedule in
execute store result storage bs.schedule: e.tick int 1 run function bs.schedule:schedule/tick with storage bs.schedule:schedule in
execute if data storage bs.schedule: e{tick:0} run return fail

function bs.schedule:schedule/dimension
execute in minecraft:overworld as B5-0-0-0-1 run function bs.schedule:schedule/location
execute if entity @s unless score @s bs.schedule.id matches -2147483648.. run function bs.schedule:schedule/tag with storage bs.schedule:
execute store result storage bs.schedule: e.tag int 1 run scoreboard players get @s bs.schedule.id
function bs.schedule:schedule/replace/register with storage bs.schedule: e
