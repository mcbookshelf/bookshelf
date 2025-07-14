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

scoreboard players reset @s bs.hmod
# Evil hack to force the attribute to instantly apply
effect give @s minecraft:instant_health 1 255 true
$attribute @s minecraft:max_health modifier add bs.health:limit $(y) add_multiplied_total
# What the fuck? Remove the attribute only after the effect is cleared, to work around Paper bug
advancement revoke @s only bs.health:on_after_heal
effect clear @s minecraft:instant_health
