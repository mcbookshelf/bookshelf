# Input:
# Storage: bs:ctx _.fsm (a FSM)

# Goal: check if the names of the states are unique
# How do we proceed?
# We will use a specific behavior of Minecraft mob's tag: the list of tags cannot have duplicates
# Following that, we can compare the size of the list of tags with the size of the list of states
# If they are different, that means that there are duplicate names

data modify storage bs:ctx _.tags set from entity B5-0-0-0-1 Tags

# We get the size of the list of states names
execute store result score #a bs.ctx run data get storage bs:ctx _.fsm.states
# We get the size of the list of tags to substract at the end
execute store result score #s bs.ctx run data get entity B5-0-0-0-1 Tags
# We set the list of tags to the list of states names
data modify entity B5-0-0-0-1 Tags append from storage bs:ctx _.fsm.states[].name
# We get the list of tags
execute store result score #b bs.ctx run data get entity B5-0-0-0-1 Tags
# We reset the tags to the default tags
data modify entity B5-0-0-0-1 Tags set from storage bs:ctx _.tags

# As our list of tags has our state names with the default tags, we need to substract the size of the list of tags before our append to the size of the list of states
scoreboard players operation #b bs.ctx -= #s bs.ctx

# We compare the size of the list of tags with the size of the list of states, if they are different, that means that there are duplicate names so we log an error and return
execute unless score #a bs.ctx = #b bs.ctx run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:check/unicity", \
  tag: "unicity", \
  message: [{text: "The names of the states are not unique."}] \
}
execute unless score #a bs.ctx = #b bs.ctx run return fail

# Else, we return success
return 1
