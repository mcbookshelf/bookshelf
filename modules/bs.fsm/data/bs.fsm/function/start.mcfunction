# Input:
# Macro: fsm_name: string
# Macro: instance_name: string
# Macro: bind: "global" | "local"

$data modify storage bs:ctx _ set value { bind: $(bind), fsm_name: $(fsm_name), instance_name: $(instance_name) }

data modify storage bs:ctx _.test set value "global"
execute store success score #s bs.ctx run data modify storage bs:ctx _.test set from storage bs:ctx _.bind

# We check if the instance already exists
$execute if score #s bs.ctx matches 0 store success score #e bs.ctx if data storage bs:data fsm.running_instances.'$(instance_name)'
execute if score #e bs.ctx matches 1 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start", \
  tag: "start", \
  message: [{text: "An instance with the name '"}, {nbt: "_.instance_name", storage: "bs:ctx"}, {text: "' already exists in the global context."}] \
}
execute if score #e bs.ctx matches 1 run return fail

$execute store success score #s bs.ctx run data modify storage bs:data fsm.running_instances.'$(instance_name)' set from storage bs:data fsm.fsm.'$(fsm_name)'
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start", \
  tag: "start", \
  message: [{text: "The FSM '"}, {nbt: "_.fsm_name", storage: "bs:ctx"}, {text: "' does not exist."}] \
}
execute if score #s bs.ctx matches 0 run return fail

execute if data storage bs:data fsm.running_instances.'$(instance_name)'
