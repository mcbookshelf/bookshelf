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

# @dummy

function #bs.xp:add_progress.in {progress:0.1}
assert result 100 run data get entity @s XpP 1000

data modify storage bs.xp:add_progress in set value {progress:0.4}
function #bs.xp:add_progress
assert result 500 run data get entity @s XpP 1000

data modify storage bs.xp:add_progress in set value {progress:1.0}
function #bs.xp:add_progress
assert result 1000 run data get entity @s XpP 1000

data modify storage bs.xp:add_progress in set value {progress:-2.0}
function #bs.xp:add_progress
assert result 0 run data get entity @s XpP 1000
