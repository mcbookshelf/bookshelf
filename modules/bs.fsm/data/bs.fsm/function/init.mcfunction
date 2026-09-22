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

# Input:
# Macro: name: string
# Macro: uses: string

$data modify storage bs:ctx _ set value { machine: "$(name)", uses: "$(uses)" }

# We check if a machine with this name is already running
$execute if data storage bs:data fsm.machines.'$(name)' run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:init", \
  tag: "init", \
  message: [{text: "A machine named '"}, {nbt: "_.machine", storage: "bs:ctx"}, {text: "' is already running in the global context."}] \
}
$execute if data storage bs:data fsm.machines.'$(name)' run return fail

# We copy the template into the running machines, which fails if the template does not exist
$execute store success score #s bs.ctx run data modify storage bs:data fsm.machines.'$(name)' set from storage $(uses)
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:init", \
  tag: "init", \
  message: [{text: "No FSM template found at '"}, {nbt: "_.uses", storage: "bs:ctx"}, {text: "'."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# We enter the initial state
$data modify storage bs:ctx _.state_name set from storage bs:data fsm.machines.'$(name)'.initial
function bs.fsm:run/enter_state_global with storage bs:ctx _
