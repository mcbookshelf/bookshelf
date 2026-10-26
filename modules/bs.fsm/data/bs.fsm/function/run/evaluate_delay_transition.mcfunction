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

# The delay is counted from the tick the state was entered: a transition is first evaluated the tick after
# it was registered, so we decrement before checking and `wait: N` fires exactly N ticks after entering (0 acts as 1)
data modify storage bs:data fsm.listened_transitions[0].condition.wait set compute default integer { \
  type: "minecraft:sub", \
  right: 1, \
  left: { type: "minecraft:storage", storage: "bs:data", path: "fsm.listened_transitions[0].condition.wait", fallback: 0 } \
}
execute store result score #d bs.ctx run data get storage bs:data fsm.listened_transitions[0].condition.wait
execute if score #d bs.ctx matches ..0 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #d bs.ctx matches ..0 run return 1

return fail
