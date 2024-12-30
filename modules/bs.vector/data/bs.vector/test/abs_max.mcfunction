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

scoreboard players set $vector.abs_max.0 bs.in 52
scoreboard players set $vector.abs_max.1 bs.in -48
scoreboard players set $vector.abs_max.2 bs.in 12
function #bs.vector:abs_max
assert score $vector.abs_max bs.out matches 52

scoreboard players set $vector.abs_max.0 bs.in -85
scoreboard players set $vector.abs_max.1 bs.in 48
scoreboard players set $vector.abs_max.2 bs.in 72
function #bs.vector:abs_max
assert score $vector.abs_max bs.out matches -85
