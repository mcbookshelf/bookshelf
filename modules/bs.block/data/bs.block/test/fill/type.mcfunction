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

setblock ~ ~ ~ minecraft:oak_stairs[facing=west]
setblock ~1 ~ ~ minecraft:oak_stairs[facing=south]

data modify storage bs:in block.fill_type set value {type:"minecraft:spruce_stairs",from:"~ ~ ~",to:"~1 ~ ~"}
function #bs.block:fill_type

assert block ~ ~ ~ minecraft:spruce_stairs[facing=west]
assert block ~1 ~ ~ minecraft:spruce_stairs[facing=south]
