# INFO ------------------------------------------------------------------------
# Copyright © 2024 Gunivers Community.

# Authors: theogiraudet
# Contributors:

# Version: 1.0
# Created: 30/03/2024 (24w13a)
# Last modification: 30/03/2024 (24w13a)

# Documentation: 
# Dependencies:
# Note: 
#  Executed when an interaction is not hovered anymore.

# CODE ------------------------------------------------------------------------

tag @s add bs.gui.target

# Get the function to execute
data modify storage bs:ctx _ set value {}
execute store result storage bs:ctx _.id int 1 run scoreboard players get @s bs.id
function bs.gui:interaction/on_event/hover/leave/get_function with storage bs:ctx _

data modify storage bs:in gui.callbacks set from storage bs:out gui.callbacks
execute if data storage bs:in gui.callbacks[0] run function bs.gui:interaction/on_event/hover/leave/execute_functions 

tag @s remove bs.gui.target