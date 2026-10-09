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

data modify storage bs.color:int_to_rgba out set value [0f,0f,0f,0f]
data modify storage bs.color:int_to_rgba out[0] set compute default float {type:"div",left:{type:"from_int",input:{type:"floor_mod",left:{type:"floor_div",left:{type:"storage",storage:"bs.color:int_to_rgba",path:"in.color"},right:65536},right:256}},right:255}
data modify storage bs.color:int_to_rgba out[1] set compute default float {type:"div",left:{type:"from_int",input:{type:"floor_mod",left:{type:"floor_div",left:{type:"storage",storage:"bs.color:int_to_rgba",path:"in.color"},right:256},right:256}},right:255}
data modify storage bs.color:int_to_rgba out[2] set compute default float {type:"div",left:{type:"from_int",input:{type:"floor_mod",left:{type:"storage",storage:"bs.color:int_to_rgba",path:"in.color"},right:256}},right:255}
data modify storage bs.color:int_to_rgba out[3] set compute default float {type:"div",left:{type:"from_int",input:{type:"floor_mod",left:{type:"floor_div",left:{type:"storage",storage:"bs.color:int_to_rgba",path:"in.color"},right:16777216},right:256}},right:255}
