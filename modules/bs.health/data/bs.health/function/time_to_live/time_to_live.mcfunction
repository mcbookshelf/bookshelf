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

$data modify storage bs:ctx _ set value $(with)

execute if data storage bs:ctx _.on_death run function bs.health:time_to_live/register_callback with entity @s
execute if data storage bs:ctx _.unit run function bs.health:time_to_live/register_unit with storage bs:ctx _
execute if data storage bs:ctx _.time store result score @s bs.ttl run data get storage bs:ctx _.time
schedule function bs.health:time_to_live/next_tick 1t
