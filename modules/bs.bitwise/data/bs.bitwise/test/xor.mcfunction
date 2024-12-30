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

scoreboard players set $bitwise.xor.a bs.in -9
scoreboard players set $bitwise.xor.b bs.in 57
function #bs.bitwise:xor
assert score $bitwise.xor bs.out matches -50

scoreboard players set $bitwise.xor.a bs.in 1234567890
scoreboard players set $bitwise.xor.b bs.in 123456
function #bs.bitwise:xor
assert score $bitwise.xor bs.out matches 1234690194
