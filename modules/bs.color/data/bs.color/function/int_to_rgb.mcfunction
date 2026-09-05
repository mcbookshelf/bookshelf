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

$data modify storage bs:ctx c set value $(color)

data modify storage bs:out color.int_to_rgb[0] set compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"c",storage:"bs:ctx"},right:65536}}
data modify storage bs:out color.int_to_rgb[1] set compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"c",storage:"bs:ctx"},right:256}}
data modify storage bs:out color.int_to_rgb[2] set compute default integer {type:"mod",right:256,left:{type:"storage",path:"c",storage:"bs:ctx"}}
