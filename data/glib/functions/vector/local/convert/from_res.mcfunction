#__________________________________________________
# INFO     Copyright © 2020 Gunivers.

# Authors: Leirof
# Contributors:
# MC Version: 1.15
# Last check:

# Original path: glib:local_vector/edit/from_res123
# Documentation: https://project.gunivers.net/projects/gunivers-lib/wiki/entity#local-vector
# Parallelizable: <true/false/global>
# Note:

#__________________________________________________
# PARAMETERS

# Input: glib.res0 (score dummy)
# Input: glib.res2 (score dummy)
# Input: glib.res3 (score dummy)

# Output: VectorX (score dummy)
# Output: VectorY (score dummy)
# Output: VectorZ (score dummy)

#__________________________________________________
# INIT

scoreboard objectives add glib.res0 dummy
scoreboard objectives add glib.res1 dummy
scoreboard objectives add glib.res2 dummy

scoreboard objectives add glib.vectorLeft dummy
scoreboard objectives add glib.vectorUp dummy
scoreboard objectives add glib.vectorFront dummy

#__________________________________________________
# CONFIG

#__________________________________________________
# CODE

scoreboard players operation @s glib.vectorLeft = @s glib.res0
scoreboard players operation @s glib.vectorUp = @s glib.res1
scoreboard players operation @s glib.vectorFront = @s glib.res2
