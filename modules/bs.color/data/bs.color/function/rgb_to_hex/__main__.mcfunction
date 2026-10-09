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

data modify storage bs.color: r set compute default integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_hex",path:"in.color[0]"},255]}}}
data modify storage bs.color: g set compute default integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_hex",path:"in.color[1]"},255]}}}
data modify storage bs.color: b set compute default integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_hex",path:"in.color[2]"},255]}}}
execute unless data storage bs.color:rgb_to_hex in.color[3] run return run function bs.color:rgb_to_hex/get_hex with storage bs.color:
data modify storage bs.color: a set compute default integer {type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_hex",path:"in.color[3]"},255]}}}
return run function bs.color:rgb_to_hex/get_hexa with storage bs.color:
