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

$execute if score #generation.part bs.data matches 2 positioned $(i_pre)$(jump_far)$(i_post) run function bs.generation:on_ellipse_outline/far_end
execute if score #generation.paused bs.data matches 1 run return fail
$execute positioned $(i_back)$(rewind_i)$(i_post) run function bs.generation:on_ellipse_outline/next with storage bs.generation: tasks[0]
