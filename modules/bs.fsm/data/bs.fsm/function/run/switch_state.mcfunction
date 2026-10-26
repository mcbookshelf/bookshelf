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
# - Macro: {source: <state_name>, context: <context>, machine: <machine>, to: <state_name>}

# We use fsm instead of _ to avoid conflicts with lambdas
$data modify storage bs:ctx fsm set value { context: "$(context)", machine: "$(machine)", state_name: "$(to)" }

# We unregister the tick command
$data remove storage bs:data fsm.ticks[{machine: "$(machine)", context: "$(context)"}]

# We remove the listened transitions for this machine from the list
$data remove storage bs:data fsm.listened_transitions[{machine: "$(machine)", context: "$(context)"}]

# We trigger the on_exit command
# Global context
$execute if data storage bs:ctx fsm{context: 'global'} run data modify storage bs:ctx fsm.command set from storage bs:data fsm.machines.'$(machine)'.states[{name: "$(source)"}].on_exit
execute if data storage bs:ctx fsm{context: 'global'} if data storage bs:ctx fsm.command run function bs.fsm:run/run_command_global with storage bs:ctx fsm
# Local context
$execute unless data storage bs:ctx fsm{context: 'global'} run data modify storage bs:ctx fsm.command set from entity $(context) data.bs:fsm.machines.'$(machine)'.states[{name: "$(source)"}].on_exit
execute unless data storage bs:ctx fsm{context: 'global'} if data storage bs:ctx fsm.command run function bs.fsm:run/run_command_local with storage bs:ctx fsm

# We remove the current flag from the previous state
# Global context
$execute if data storage bs:ctx fsm{context: 'global'} run data remove storage bs:data fsm.machines.'$(machine)'.states[{name: "$(source)"}].current
# Local context
$execute unless data storage bs:ctx fsm{context: 'global'} run data remove entity $(context) data.bs:fsm.machines.'$(machine)'.states[{name: "$(source)"}].current

# We enter in the new state
# Global context
execute if data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/enter_state_global with storage bs:ctx fsm
# Local context
execute unless data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/enter_state_local with storage bs:ctx fsm

return 1
