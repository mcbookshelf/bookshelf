# Input:
# Macro: $(state) (a state name)
# Storage: bs:ctx _.states_to_find (a list of states name)

# Output:
# Set the state has selected
# If no state, return fail

$return run data modify storage bs:ctx _.states_to_find[{name: '$(state)'}].selected set value true
