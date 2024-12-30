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

# Note:
# - This function returns the or bitwise between two numbers.
# - Example: -178 | 32165 = -17
# - Formula: a | b = (a + b) - (a & b)
# The result is the number composed by keeping all one in the two binary representations of these numbers.

scoreboard players operation #a bs.ctx = $bitwise.or.a bs.in
execute store result score $bitwise.or bs.out run scoreboard players operation #b bs.ctx = $bitwise.or.b bs.in
scoreboard players operation $bitwise.or bs.out += $bitwise.or.a bs.in
function bs.bitwise:and/compute
return run scoreboard players operation $bitwise.or bs.out -= #x bs.ctx
