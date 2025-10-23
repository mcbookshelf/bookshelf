# Input:
# Storage: bs:ctx _.states (a list of states)
# Entity: B5-0-0-0-1 Tags (the list of all states names)

# Output:
# Fail if the current transition is not valid

execute unless data storage bs:ctx _.states[0].transitions[0] run return 1

# First, we have if the 'to' state exists
# For that, we will use the entity Tags array property which cannot store multiple occurrences of the same value
# So if we add inside the name of all the states, then the 'to' state, the size of the array will not change
data modify storage bs:ctx _.tags set from entity B5-0-0-0-1 Tags

execute store result score #a bs.ctx run data get entity B5-0-0-0-1 Tags

data modify entity B5-0-0-0-1 Tags append from storage bs:ctx _.states[0].transitions[0].to
execute store result score #b bs.ctx run data get entity B5-0-0-0-1 Tags

# We restore the previous tags
data modify entity B5-0-0-0-1 Tags set from storage bs:ctx _.tags

execute unless score #a bs.ctx = #b bs.ctx run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A transition of '"}, {nbt: "_.states[0].name", storage: "bs:ctx"}, {text: "' refers an unknown state: "}, {nbt: "_.states[0].transitions[0].to", storage: "bs:ctx"}] \
}
execute unless score #a bs.ctx = #b bs.ctx run return fail


# We check if the transition has a condition
execute unless data storage bs:ctx _.states[0].transitions[0].condition run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A transition of '"}, {nbt: "_.states[0].name", storage: "bs:ctx"}, {text: "' does not have a condition."}] \
}
execute unless data storage bs:ctx _.states[0].transitions[0].condition run return fail

# We check if the condition is "manual"
data modify storage bs:ctx _.condition set value "manual"
execute store success score #s bs.ctx run data modify storage bs:ctx _.condition set from storage bs:ctx _.states[0].transitions[0].condition
# If we fail to overwrite "manual", it means that the condition is "manual" so we can return
execute if score #s bs.ctx matches 0 run return 1

# If the condition is not "manual", we need to check if the condition is an object
execute unless data storage bs:ctx _.states[0].transitions[0].condition.type run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A transition of '"}, {nbt: "_.states[0].name", storage: "bs:ctx"}, {text: "' has an invalid condition."}] \
}
execute unless data storage bs:ctx _.states[0].transitions[0].condition.type run return fail

# Now, we need to check the validity of the condition object, notably the wait
execute unless data storage bs:ctx _.states[0].transitions[0].condition.wait run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A transition of '"}, {nbt: "_.states[0].name", storage: "bs:ctx"}, {text: "' does not have a wait in its condition."}] \
}
execute unless data storage bs:ctx _.states[0].transitions[0].condition.wait run return fail

# We check if the condition type is valid
data modify storage bs:ctx _.condition set value []
data modify storage bs:ctx _.condition append from storage bs:ctx _.states[0].transitions[0].condition

execute store success score #s bs.ctx unless data storage bs:ctx _.states[0].transitions[0].condition[{type: "predicate"}] \
unless data storage bs:ctx _.states[0].transitions[0].condition[{type: "command"}] \
unless data storage bs:ctx _.states[0].transitions[0].condition[{type: "hook"}] \
unless data storage bs:ctx _.states[0].transitions[0].condition[{type: "delay"}]

execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A transition of '"}, {nbt: "_.states[0].name", storage: "bs:ctx"}, {text: "' has an invalid condition."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# If we pass all the checks, we can continue to the next transition
data remove storage bs:ctx _.states[0].transitions[0]
return run function bs.fsm:check/internal/well_formedness_transition
