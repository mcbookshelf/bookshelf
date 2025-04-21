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

# Give healing effect and revoke advancements that track when the effect is actually applied
effect give @s minecraft:instant_health 1 28 true
advancement revoke @s only bs.health:on_before_heal_hurt
advancement revoke @s only bs.health:on_before_heal_tick
advancement revoke @s only bs.health:on_heal
