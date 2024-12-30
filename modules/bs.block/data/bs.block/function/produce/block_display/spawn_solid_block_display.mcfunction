# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

data modify storage bs:ctx _ set value {transformation:[1f,0f,0f,-0.5f,0f,1f,0f,0f,0f,0f,1f,-0.5f,0f,0f,0f,1f],Passengers:[{id:"minecraft:shulker",active_effects:[{id:"invisibility",Amplifier:1b,duration:-1,show_particles:0b}],AttachFace:0b,Invulnerable:1b,NoAI:1b,NoGravity:1b,PersistenceRequired:1b,Silent:1b}]}
data modify storage bs:ctx _ merge from storage bs:in block.spawn_solid_block_display.extra_nbt
data modify storage bs:ctx _.block_state.Name set from storage bs:in block.spawn_solid_block_display.type
data modify storage bs:ctx _.block_state.Properties set from storage bs:in block.spawn_solid_block_display.properties

function bs.block:produce/block_display/run with storage bs:ctx
