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

execute store result score #tag bs.schedule.id run data get storage bs.schedule: tick[0].tag
execute if score #tag bs.schedule.id matches 1.. run function bs.schedule:runner/run_as with storage bs.schedule: tick[0]
execute if score #tag bs.schedule.id matches 0 run function bs.schedule:runner/run with storage bs.schedule: tick[0]
data remove storage bs.schedule: tick[0]
execute if data storage bs.schedule: tick[0] run function bs.schedule:runner/loop
