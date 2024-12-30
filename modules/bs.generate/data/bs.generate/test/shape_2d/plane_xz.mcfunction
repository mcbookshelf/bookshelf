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

function #bs.generate:shape_2d {width:2,height:2,run:"setblock ~ ~ ~ minecraft:stone",with:{direction:"xz"}}

assert block ~ ~ ~ minecraft:stone
assert block ~1 ~ ~ minecraft:stone
assert block ~ ~ ~1 minecraft:stone
assert block ~1 ~ ~1 minecraft:stone
