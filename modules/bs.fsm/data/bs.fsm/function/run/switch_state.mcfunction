# Input:
# - Macro: {source: <state_name>, context: <context>, instance_name: <instance_name>, to: <state_name>}

# We use fsm instead of _ to avoid conflicts with lambdas
$data modify storage bs:ctx fsm set value { context: "$(context)", instance_name: "$(instance_name)", state_name: "$(to)" }

# We unregister the tick command
$data remove storage bs:data fsm.ticks[{instance_name: "$(instance_name)", context: "$(context)"}]

# We remove the listened transitions for this instance from the list
$data remove storage bs:data fsm.listened_transitions[{instance_name: "$(instance_name)", context: "$(context)"}]

# We trigger the on_exit command
# Global context
$execute if data storage bs:ctx fsm{context: 'global'} run data modify storage bs:ctx fsm.command set from storage bs:data fsm.running_instances.'$(instance_name)'.states[{name: "$(source)"}].on_exit
execute if data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/run_command_global with storage bs:ctx fsm
# Local context
$execute unless data storage bs:ctx fsm{context: 'global'} run data modify storage bs:ctx fsm.command set from entity $(context) data.bs:fsm.running_instances.'$(instance_name)'.states[{name: "$(source)"}].on_exit
execute unless data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/run_command_local with storage bs:ctx fsm

# We remove the current flag from the previous state
# Global context
$execute if data storage bs:ctx fsm{context: 'global'} run data remove storage bs:data fsm.running_instances.'$(instance_name)'.states[{name: "$(source)"}].current
# Local context
$execute unless data storage bs:ctx fsm{context: 'global'} run data remove entity $(context) data.bs:fsm.running_instances.'$(instance_name)'.states[{name: "$(source)"}].current

# We enter in the new state
# Global context
execute if data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/enter_state_global with storage bs:ctx fsm
# Local context
execute unless data storage bs:ctx fsm{context: 'global'} run function bs.fsm:run/enter_state_local with storage bs:ctx fsm
