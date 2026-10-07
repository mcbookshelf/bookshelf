# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

# Area effect clouds
summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["ward.hitbox.area_effect_cloud"],Radius:3f}
execute as @n[tag=ward.hitbox.area_effect_cloud] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-3f,0f,-3f,3f,0.5f,3f]

# Armor stands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.hitbox.armor_stand"]}
execute as @n[tag=ward.hitbox.armor_stand] run assert predicate bs.hitbox:get_entity/targetable
execute as @n[tag=ward.hitbox.armor_stand] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.25f,0f,-0.25f,0.25f,1.975f,0.25f]

# Small armor stands, scaled
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.hitbox.armor_stand.small"],Small:1b}
attribute @n[tag=ward.hitbox.armor_stand.small] minecraft:scale base set 2
execute as @n[tag=ward.hitbox.armor_stand.small] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.25f,0f,-0.25f,0.25f,1.975f,0.25f]

# Marker armor stands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.hitbox.armor_stand.marker"],Marker:1b}
execute as @n[tag=ward.hitbox.armor_stand.marker] run assert result 0 run function #bs.hitbox:get_entity/sized

# Camels
summon minecraft:camel ~ ~ ~ {Tags:["ward.hitbox.camel"]}
execute as @n[tag=ward.hitbox.camel] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.85f,0f,-0.85f,0.85f,2.375f,0.85f]

# Sitting camels
summon minecraft:camel ~ ~ ~ {Tags:["ward.hitbox.camel.sitting"],LastPoseTick:-1L}
execute as @n[tag=ward.hitbox.camel.sitting] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.85f,0f,-0.85f,0.85f,0.94500005f,0.85f]

# Baby camels
summon minecraft:camel ~ ~ ~ {Tags:["ward.hitbox.camel.baby"],Age:-24000}
execute as @n[tag=ward.hitbox.camel.baby] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.475f,0f,-0.475f,0.475f,1.4f,0.475f]

# Camel husks have no baby size
summon minecraft:camel_husk ~ ~ ~ {Tags:["ward.hitbox.camel_husk"],Age:-24000}
execute as @n[tag=ward.hitbox.camel_husk] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.85f,0f,-0.85f,0.85f,2.375f,0.85f]

# Goats
summon minecraft:goat ~ ~ ~ {Tags:["ward.hitbox.goat"]}
execute as @n[tag=ward.hitbox.goat] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.45f,0f,-0.45f,0.45f,1.3f,0.45f]

# Long jumping goats, told by their box no longer reaching their height, are scaled by 0.7
scoreboard players set #s bs.ctx 1000000
data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,0f,1.3f,0f]]
data modify storage bs.hitbox: i set value 1.3f
execute as @n[tag=ward.hitbox.goat] run function bs.hitbox:get_entity/registry/goat/long_jump with storage bs.hitbox:
assert score #s bs.ctx matches 1000000
assert result 1299..1300 run data get storage bs.hitbox:get_entity out[0][4] 1000
data modify storage bs.hitbox: i set value 5f
execute as @n[tag=ward.hitbox.goat] run function bs.hitbox:get_entity/registry/goat/long_jump with storage bs.hitbox:
assert score #s bs.ctx matches 700000
assert result 909..910 run data get storage bs.hitbox:get_entity out[0][4] 1000

# Baby goats
summon minecraft:goat ~ ~ ~ {Tags:["ward.hitbox.goat.baby"],Age:-24000}
execute as @n[tag=ward.hitbox.goat.baby] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.225f,0f,-0.225f,0.225f,0.65f,0.225f]

# Interactions
summon minecraft:interaction ~ ~ ~ {Tags:["ward.hitbox.interaction"],width:2f,height:3f}
execute as @n[tag=ward.hitbox.interaction] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-1f,0f,-1f,1f,3f,1f]

# Item frames up
summon minecraft:item_frame ~ ~ ~ {Tags:["ward.hitbox.item_frame.up"],Facing:1b}
execute as @n[tag=ward.hitbox.item_frame.up] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.375f,-0.03125f,-0.375f,0.375f,0.03125f,0.375f]

# Item frames north
summon minecraft:glow_item_frame ~ ~ ~ {Tags:["ward.hitbox.item_frame.north"],Facing:2b}
execute as @n[tag=ward.hitbox.item_frame.north] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.375f,-0.375f,-0.03125f,0.375f,0.375f,0.03125f]

# Item frames east
summon minecraft:item_frame ~ ~ ~ {Tags:["ward.hitbox.item_frame.east"],Facing:5b}
execute as @n[tag=ward.hitbox.item_frame.east] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.03125f,-0.375f,-0.375f,0.03125f,0.375f,0.375f]

# Mannequins crouching
summon minecraft:mannequin ~ ~ ~ {Tags:["ward.hitbox.mannequin.crouching"],pose:"crouching"}
execute as @n[tag=ward.hitbox.mannequin.crouching] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.3f,0f,-0.3f,0.3f,1.5f,0.3f]

# Mannequins swimming
summon minecraft:mannequin ~ ~ ~ {Tags:["ward.hitbox.mannequin.swimming"],pose:"swimming"}
execute as @n[tag=ward.hitbox.mannequin.swimming] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.3f,0f,-0.3f,0.3f,0.6f,0.3f]

# Paintings north
summon minecraft:painting ~ ~ ~ {Tags:["ward.hitbox.painting.north"],facing:2b,variant:"minecraft:skeleton"}
execute as @n[tag=ward.hitbox.painting.north] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-2f,-1.5f,-0.03125f,2f,1.5f,0.03125f]

# Paintings west
summon minecraft:painting ~ ~ ~ {Tags:["ward.hitbox.painting.west"],facing:1b,variant:"minecraft:wanderer"}
execute as @n[tag=ward.hitbox.painting.west] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.03125f,-1f,-0.5f,0.03125f,1f,0.5f]

# Phantoms
summon minecraft:phantom ~ ~ ~ {Tags:["ward.hitbox.phantom"],size:4}
execute as @n[tag=ward.hitbox.phantom] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.72f,0f,-0.72f,0.72f,0.8f,0.72f]

# Pufferfish
summon minecraft:pufferfish ~ ~ ~ {Tags:["ward.hitbox.pufferfish"],PuffState:1}
execute as @n[tag=ward.hitbox.pufferfish] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.245f,0f,-0.245f,0.245f,0.49f,0.245f]

# An entity whose size is 0 has no box
summon minecraft:interaction ~ ~ ~ {Tags:["ward.hitbox.interaction.flat"],width:2f,height:0f}
execute as @n[tag=ward.hitbox.interaction.flat] run assert result 0 run function #bs.hitbox:get_entity/sized
summon minecraft:interaction ~ ~ ~ {Tags:["ward.hitbox.interaction.thin"],width:0f,height:3f}
execute as @n[tag=ward.hitbox.interaction.thin] run assert result 0 run function #bs.hitbox:get_entity/sized
summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["ward.hitbox.area_effect_cloud.empty"],Radius:0f}
execute as @n[tag=ward.hitbox.area_effect_cloud.empty] run assert result 0 run function #bs.hitbox:get_entity/sized
