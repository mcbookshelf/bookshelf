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

# @batch bs.vector

scoreboard players set $vector.length_squared.0 bs.in 4000
scoreboard players set $vector.length_squared.1 bs.in 5000
scoreboard players set $vector.length_squared.2 bs.in 1000

function #bs.vector:length_squared {scaling:1000}

assert score $vector.length_squared bs.out matches 42000
