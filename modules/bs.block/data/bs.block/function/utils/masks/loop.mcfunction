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

$execute if data storage bs:ctx _{negate:0b} run data modify storage bs:ctx _.mask set value "if block ~$(x) ~$(y) ~$(z) $(block) $(mask)"
$execute if data storage bs:ctx _{negate:1b} run data modify storage bs:ctx _.mask set value "unless block ~$(x) ~$(y) ~$(z) $(block) $(mask)"

data remove storage bs:data block._.masks[-1]
data modify storage bs:ctx _ merge value {x:0,y:0,z:0,negate:0b,block:0b}
data modify storage bs:ctx _ merge from storage bs:data block._.masks[-1]
execute unless data storage bs:ctx _{block:0b} run function bs.block:utils/masks/loop with storage bs:ctx _
