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

data modify storage bs.color: channel.r set compute default integer {type:"from_float",input:{type:"mul",inputs:[{type:"storage","storage":"bs.color:rgb_to_hex",path:"in.color[0]"},255]}}
data modify storage bs.color: channel.g set compute default integer {type:"from_float",input:{type:"mul",inputs:[{type:"storage","storage":"bs.color:rgb_to_hex",path:"in.color[1]"},255]}}
data modify storage bs.color: channel.b set compute default integer {type:"from_float",input:{type:"mul",inputs:[{type:"storage","storage":"bs.color:rgb_to_hex",path:"in.color[2]"},255]}}
data modify storage bs.color: channel.a set compute default integer {type:"from_float",input:{type:"mul",inputs:[{type:"storage","storage":"bs.color:rgb_to_hex",path:"in.color[3]"},255]}}

execute unless data storage bs.color:rgb_to_hex in.color[3] run function bs.color:utils/get_hexes with storage bs.color: channel
execute unless data storage bs.color:rgb_to_hex in.color[3] run function bs.color:utils/concat_hexes with storage bs.color: channel_h
execute if data storage bs.color:rgb_to_hex in.color[3] run function bs.color:utils/get_hexes_a with storage bs.color: channel
execute if data storage bs.color:rgb_to_hex in.color[3] run function bs.color:utils/concat_hexes_a with storage bs.color: channel_h

data modify storage bs.color:rgb_to_hex out set from storage bs.color: hex
