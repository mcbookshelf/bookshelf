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

data modify storage bs.animation: stack append value {step:1}
data modify storage bs.animation: stack[-1].nbt.data set from entity @s data
$data modify storage bs.animation: stack[-1]._ append from storage bs.animation: stack[-1].nbt.data."bs.animation"[{id:"$(id)"}]
execute unless data storage bs.animation: stack[-1]._[0] run return run function bs.animation:utils/fail
$data remove storage bs.animation: stack[-1].nbt.data."bs.animation"[{id:"$(id)"}]

data modify storage bs.animation: stack[-1].step set from storage bs.animation:step in.step

function bs.animation:step/loop with storage bs.animation: stack[-1]._[0]
data modify entity @s {} merge from storage bs.animation: stack[-1].nbt
return run data remove storage bs.animation: stack[-1]
