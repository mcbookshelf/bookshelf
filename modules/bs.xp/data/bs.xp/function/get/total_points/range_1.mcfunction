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

# level^2 + 6 × level (at levels 0–16)
scoreboard players operation #x bs.ctx *= 6 bs.const
scoreboard players operation #y bs.ctx *= #y bs.ctx
scoreboard players operation $xp.get_total_points bs.out += #x bs.ctx
return run scoreboard players operation $xp.get_total_points bs.out += #y bs.ctx
