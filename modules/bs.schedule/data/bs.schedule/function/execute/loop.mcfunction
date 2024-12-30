# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

data modify entity @s {} merge from storage bs:data schedule.slice[-1]
execute if data storage bs:data schedule.slice[-1].esid run function bs.schedule:execute/run/with_entity with storage bs:data schedule.slice[-1]
execute unless data storage bs:data schedule.slice[-1].esid run function bs.schedule:execute/run/without_entity with storage bs:data schedule.slice[-1]

data remove storage bs:data schedule.slice[-1]
execute if data storage bs:data schedule.slice[-1] run return run function bs.schedule:execute/loop
tp @s -30000000 0 1600
