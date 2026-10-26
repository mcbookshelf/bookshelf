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

# The indexes tell the position the command runs at, in the order of the axes
data modify storage bs.generation:on_cuboid in set value {run:'execute if predicate {type:"int_value_check",value:"bs.generation:i",test:1} if predicate {type:"int_value_check",value:"bs.generation:j",test:0} if predicate {type:"int_value_check",value:"bs.generation:k",test:2} run setblock ~ ~ ~ minecraft:stone',size:[2,2,3]}
function #bs.generation:on_cuboid/yzx
assert block ~2 ~1 ~ minecraft:stone
assert not block ~ ~1 ~ minecraft:stone
assert not block ~1 ~ ~ minecraft:stone
