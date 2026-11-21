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

execute unless data storage bs.color:rgb_to_int in.color[3] run return run execute store result storage bs.color:rgb_to_int out int 1 run compute default integer {type:"add",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[2]"},255]}}},{type:"mul",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[1]"},255]}}},256]},{type:"mul",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[0]"},255]}}},65536]}]}
return run execute store result storage bs.color:rgb_to_int out int 1 run compute default integer {type:"add",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[2]"},255]}}},{type:"mul",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[1]"},255]}}},256]},{type:"mul",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[0]"},255]}}},65536]},{type:"mul",inputs:[{type:"add",inputs:[{type:"floor_mod",left:{type:"add",inputs:[{type:"from_float",input:{type:"round",input:{type:"mul",inputs:[{type:"storage",storage:"bs.color:rgb_to_int",path:"in.color[3]"},255]}}},128]},right:256},-128]},16777216]}]}
