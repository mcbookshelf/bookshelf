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

scoreboard players set $time.hours bs.out -1
scoreboard players set $time.minutes bs.out -1
scoreboard players set $time.seconds bs.out -1

function #bs.time:get

assert score $time.hours bs.out matches 0..
assert score $time.minutes bs.out matches 0..
assert score $time.seconds bs.out matches 0..
