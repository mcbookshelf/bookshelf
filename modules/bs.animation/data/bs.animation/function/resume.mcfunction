# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Push the current entity animation onto the stack
data modify storage bs:data animation append value {}
data modify storage bs:data animation[-1].nbt.data set from entity @s data
$data modify storage bs:data animation[-1].def append from storage bs:data animation[-1].nbt.data."bs.animation"[{id:"$(id)"}]
execute if data storage bs:data animation[-1].def[-1].tick run return run function bs.animation:utils/fail
execute unless data storage bs:data animation[-1].def[-1].step run return run function bs.animation:utils/fail

# Evaluate the animation at its current state without advancing
data modify storage bs:data animation[-1].def[-1]._step set from storage bs:data animation[-1].def[-1].step
data modify storage bs:data animation[-1].def[-1].step set value 0
function bs.animation:utils/proc/step
data modify storage bs:data animation[-1].def[-1].step set from storage bs:data animation[-1].def[-1]._step
data remove storage bs:data animation[-1].def[-1]._step

# Apply the evaluated animation to the entity and pop the stack
$data modify storage bs:data animation[-1].nbt.data."bs.animation"[{id:"$(id)"}] set from storage bs:data animation[-1].def[-1]
data modify entity @s {} merge from storage bs:data animation[-1].nbt
data remove storage bs:data animation[-1]
