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

scoreboard players set $math.gcd.a bs.in 16
scoreboard players set $math.gcd.b bs.in 12
function #bs.math:gcd
assert score $math.gcd bs.out matches 4

scoreboard players set $math.gcd.a bs.in 56616
scoreboard players set $math.gcd.b bs.in 1568
function #bs.math:gcd
assert score $math.gcd bs.out matches 56
