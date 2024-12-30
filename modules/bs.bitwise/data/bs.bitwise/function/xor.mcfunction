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
# - This function returns the exclusive or bitwise between two numbers.
# - Example: -178 ^ 32165 = -32021
# - Formula: a ^ b = (a + b) - 2*(a & b)
# The result is the number composed by putting one at all bits where the value in the two binary representations of these numbers is different.

scoreboard players operation #a bs.ctx = $bitwise.xor.a bs.in
execute store result score $bitwise.xor bs.out run scoreboard players operation #b bs.ctx = $bitwise.xor.b bs.in
scoreboard players operation $bitwise.xor bs.out += $bitwise.xor.a bs.in
function bs.bitwise:and/compute
scoreboard players operation $bitwise.xor bs.out -= #x bs.ctx
return run scoreboard players operation $bitwise.xor bs.out -= #x bs.ctx
