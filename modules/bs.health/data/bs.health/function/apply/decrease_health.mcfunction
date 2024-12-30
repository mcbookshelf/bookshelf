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

advancement grant @s only bs.health:restore_health
attribute @s minecraft:max_health modifier remove bs.health:limit
$attribute @s minecraft:max_health modifier add bs.health:limit $(x) add_value
effect give @s minecraft:health_boost 1 0 true
effect clear @s minecraft:health_boost
effect clear @s minecraft:instant_health
attribute @s minecraft:max_health modifier remove bs.health:limit
