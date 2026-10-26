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

$execute if data storage bs.schedule: queue[].e[{id:"$(id)",tag:$(tag)}] run return fail

execute store result storage bs.schedule: e.tick int 1 run function bs.schedule:schedule/tick with storage bs.schedule:schedule in
execute if data storage bs.schedule: e{tick:0} run return fail

function bs.schedule:schedule/dimension
execute in minecraft:overworld as B5-0-0-0-1 run function bs.schedule:schedule/location
return run function bs.schedule:schedule/unique/register with storage bs.schedule: e
