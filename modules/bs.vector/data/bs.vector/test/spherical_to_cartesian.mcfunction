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

await entity B5-0-0-0-1

scoreboard players set $vector.spherical_to_cartesian.0 bs.in 15250
scoreboard players set $vector.spherical_to_cartesian.1 bs.in 42000
scoreboard players set $vector.spherical_to_cartesian.2 bs.in 8525

function #bs.vector:spherical_to_cartesian {scaling:1000}

assert score $vector.spherical_to_cartesian.0 bs.out matches -1667..-1665
assert score $vector.spherical_to_cartesian.1 bs.out matches -5704..-5702
assert score $vector.spherical_to_cartesian.2 bs.out matches 6111..6113
