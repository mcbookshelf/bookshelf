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
# - Macro machine: string
# - Macro state_name: string - new current state name

# We set the new state as current state
$data modify storage bs:data fsm.machines.'$(machine)'.states[{name: "$(state_name)"}].current set value true

$data modify storage bs:ctx _.state set from storage bs:data fsm.machines.'$(machine)'.states[{name: "$(state_name)"}]

# We prepare the transitions to be listened
# _.tmp is shared scratch: reset it so a state without transitions listens to nothing
data modify storage bs:ctx _.tmp set value []
data modify storage bs:ctx _.tmp set from storage bs:ctx _.state.transitions
# We remove the manual transitions since we do not need to listen to them
data remove storage bs:ctx _.tmp[{condition: "manual"}]
# A [] target appends an element to an empty list, so we only inject when one is left
execute if data storage bs:ctx _.tmp[0] run data modify storage bs:ctx _.tmp[].source set from storage bs:ctx _.state.name
execute if data storage bs:ctx _.tmp[0] run data modify storage bs:ctx _.tmp[].context set value "global"
execute if data storage bs:ctx _.tmp[0] run data modify storage bs:ctx _.tmp[].global set value true
$execute if data storage bs:ctx _.tmp[0] run data modify storage bs:ctx _.tmp[].machine set value "$(machine)"
# Flagged as checked so a pass in progress does not evaluate them: transitions are only evaluated from the next tick on
execute if data storage bs:ctx _.tmp[0] run data modify storage bs:ctx _.tmp[].checked set value true

# We check the listened_transitions list size
execute store result score #s bs.ctx run data get storage bs:data fsm.listened_transitions

# We add the transitions to the listened transitions list
data modify storage bs:data fsm.listened_transitions append from storage bs:ctx _.tmp[]

# If before, the listened_transitions list was empty, we start the listened transitions loop
execute if score #s bs.ctx matches ..0 run schedule function bs.fsm:run/evaluate_transitions 1t

# We execute the on_enter command
execute if data storage bs:ctx _.state.on_enter run data modify storage bs:ctx _.command set from storage bs:ctx _.state.on_enter
execute if data storage bs:ctx _.state.on_enter run function bs.fsm:run/run_command_global with storage bs:ctx _

# A state with no outgoing transition can never be left: the machine is over, we stop it
$execute unless data storage bs:ctx _.state.transitions[0] run return run function bs.fsm:run/stop_global { machine: "$(machine)" }

# We register the on_tick command, flagged as global so the tick loop runs it in the global context
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp set value { context: "global", global: true }
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp.command set from storage bs:ctx _.state.on_tick
$execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp.machine set value "$(machine)"
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:data fsm.ticks append from storage bs:ctx _.tmp
# If this is the only command on the ticks list, we start the tick loop
execute if data storage bs:data fsm.ticks[0] unless data storage bs:data fsm.ticks[1] run schedule function bs.fsm:run/tick 1t
