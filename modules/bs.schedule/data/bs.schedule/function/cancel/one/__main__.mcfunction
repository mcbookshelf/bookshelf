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

execute unless score @s bs.schedule.id matches -2147483648.. run return fail
data modify storage bs.schedule: e set from storage bs.schedule:cancel in
execute store result storage bs.schedule: e.tag int 1 run scoreboard players get @s bs.schedule.id
return run function bs.schedule:cancel/one/remove with storage bs.schedule: e
