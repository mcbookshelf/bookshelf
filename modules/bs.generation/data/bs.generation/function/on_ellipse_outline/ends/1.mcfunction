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

$execute positioned $(i_pre)$(jump)$(i_post) run $(run)
scoreboard players operation #generation.end bs.data = #generation.last_i bs.data
scoreboard players operation #generation.i bs.data = #generation.skip bs.data
$execute positioned $(i_pre)$(last_i)$(i_post) positioned $(i_back)$(jump)$(i_post) run $(run)
