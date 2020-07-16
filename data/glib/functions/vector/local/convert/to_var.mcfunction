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

# Input: VectorX (score dummy)
# Input: VectorY (score dummy)
# Input: VectorZ (score dummy)

# Output: glib.var0 (score dummy)
# Output: glib.var1 (score dummy)
# Output: glib.var2 (score dummy)

#__________________________________________________
# INIT

scoreboard objectives add glib.var0 dummy
scoreboard objectives add glib.var1 dummy
scoreboard objectives add glib.var2 dummy

scoreboard objectives add glib.vectorLeft dummy
scoreboard objectives add glib.vectorUp dummy
scoreboard objectives add glib.vectorFront dummy

#__________________________________________________
# CONFIG

#__________________________________________________
# CODE

scoreboard players operation @s glib.var0 = @s glib.vectorLeft
scoreboard players operation @s glib.var1 = @s glib.vectorUp
scoreboard players operation @s glib.var2 = @s glib.vectorFront
