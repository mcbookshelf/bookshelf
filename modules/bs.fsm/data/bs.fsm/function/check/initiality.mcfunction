# Input:
# Storage: bs:ctx _.fsm (a FSM)

# Goal: check if the specified initial state exist in the FSM
execute store success score #s bs.ctx run function bs.fsm:check/internal/initiality with storage bs:ctx _.fsm
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The initial state does not exist in the FSM."}] \
}
execute if score #s bs.ctx matches 0 run return fail

return 1
