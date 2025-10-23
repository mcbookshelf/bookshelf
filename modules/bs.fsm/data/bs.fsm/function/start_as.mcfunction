# Input:
# Macro: fsm_name: string
# Macro: instance_name: string

$data modify storage bs:ctx _ set value { fsm_name: $(fsm_name), instance_name: $(instance_name) }

# We get the String UUID of the entity
tag @s add bs.fsm.entity
data modify entity B5-0-0-0-2 text set value { selector: "@n[tag=bs.fsm.entity]" }
data modify storage bs:ctx _.context set from entity B5-0-0-0-2 text.insertion

# We check if the instance already exists
$execute store success score #s bs.ctx if data entity @n[tag=bs.fsm.entity] data.bs:fsm.running_instances.'$(instance_name)'
execute if score #s bs.ctx matches 1 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start_as", \
  tag: "start_as", \
  message: [{text: "An instance with the name '"}, {nbt: "_.instance_name", storage: "bs:ctx"}, {text: "' already exists for entity '"}, {nbt: "_.context", storage: "bs:ctx"}, {text: "'."}] \
}
execute if score #s bs.ctx matches 1 run tag @s remove bs.fsm.entity
execute if score #s bs.ctx matches 1 run return fail

# We create the instance of the FSM for the entity
$execute store success score #s bs.ctx run data modify entity @n[tag=bs.fsm.entity] data.bs:fsm.running_instances.'$(instance_name)' set from storage bs:data fsm.fsm.'$(fsm_name)'
# If the instance was not created, we log an error since the FSM does not exist
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start_as", \
  tag: "start_as", \
  message: [{text: "The FSM '"}, {nbt: "_.fsm_name", storage: "bs:ctx"}, {text: "' does not exist."}] \
}
execute if score #s bs.ctx matches 0 run tag @s remove bs.fsm.entity
execute if score #s bs.ctx matches 0 run return fail

# We enter the initial state
$data modify storage bs:ctx _.state_name set from storage bs:data fsm.fsm.'$(fsm_name)'.initial
function bs.fsm:run/enter_state_local with storage bs:ctx _
