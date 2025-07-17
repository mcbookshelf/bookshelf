# Input:
# Macro: name: string
# Macro: fsm: {
#   initial: state
#   on_cancel: function
#   states: [
#     {
#       name: string
#       on_tick: function
#       on_exit: function
#       on_enter: function
#       final?: boolean
#       transitions?: [
#         {
#           name?: string
#           condition: 'manual' | { type: 'predicate', wait: string } | { type: 'function', wait: string } | { type: 'hook', wait: string } | { type: 'delay', wait: string }
#           to: state
#         }
#       ]
#     }
#   ]
# }

# Check if the FSM already exists.
$execute if data storage bs:data fsm.fsm.'$(name)' run function #bs.log:error { \
  namespace: bs.fsm, \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: ["A FSM with the name '$(name)' already exists."] \
}
$execute if data storage bs:data fsm.fsm.'$(name)' run return fail

$data modify storage bs:ctx _ set value { fsm: $(fsm) }

# Check if the FSM is valid
execute store success score #s bs.ctx run function bs.fsm:check/is_valid
execute if score #s bs.ctx matches 0 run return fail

$data modify storage bs:data fsm.fsm.'$(name)' set value $(fsm)
