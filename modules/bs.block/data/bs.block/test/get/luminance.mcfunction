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

data modify storage bs:out block set value {}

setblock ~ ~ ~ minecraft:light[level=0]
function #bs.block:get_luminance
assert data storage bs:out block{ luminance: 0 }

setblock ~ ~ ~ minecraft:light[level=4]
function #bs.block:get_luminance
assert data storage bs:out block{ luminance: 4 }

setblock ~ ~ ~ minecraft:light[level=6]
function #bs.block:get_luminance
assert data storage bs:out block{ luminance: 6 }

setblock ~ ~ ~ minecraft:redstone_torch
function #bs.block:get_luminance
assert data storage bs:out block{ luminance: 7 }

setblock ~ ~ ~ minecraft:glowstone
function #bs.block:get_luminance
assert data storage bs:out block{ luminance: 15 }
