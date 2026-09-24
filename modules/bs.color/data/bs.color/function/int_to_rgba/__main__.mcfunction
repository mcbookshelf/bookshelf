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


execute store result storage bs.color:int_to_rgba out[3] float 0.00392156862 store result score $color.int_to_rgba.a bs.out run compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"in.color",storage:"bs.color:int_to_rgba"},right:16777216}}
execute store result storage bs.color:int_to_rgba out[0] float 0.00392156862 store result score $color.int_to_rgba.r bs.out run compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"in.color",storage:"bs.color:int_to_rgba"},right:65536}}
execute store result storage bs.color:int_to_rgba out[1] float 0.00392156862 store result score $color.int_to_rgba.g bs.out run compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"in.color",storage:"bs.color:int_to_rgba"},right:256}}
execute store result storage bs.color:int_to_rgba out[2] float 0.00392156862 store result score $color.int_to_rgba.b bs.out run compute default integer {type:"mod",right:256,left:{type:"storage",path:"in.color",storage:"bs.color:int_to_rgba"}}
