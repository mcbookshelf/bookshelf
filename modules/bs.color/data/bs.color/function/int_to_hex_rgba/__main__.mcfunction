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

$data modify storage bs.color: color set value $(color)

data modify storage bs.color: channel.alpha set compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"color",storage:"bs.color:"},right:16777216}}
data modify storage bs.color: channel.red set compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"color",storage:"bs.color:"},right:65536}}
data modify storage bs.color: channel.green set compute default integer {type:"mod",right:256,left:{type:"div",left:{type:"storage",path:"color",storage:"bs.color:"},right:256}}
data modify storage bs.color: channel.blue set compute default integer {type:"mod",right:256,left:{type:"storage",path:"color",storage:"bs.color:"}}

function bs.color:utils/get_hexes_a with storage bs.color: channel
function bs.color:utils/concat_hexes_a with storage bs:ctx channel_h
data modify storage bs.color:int_to_hex_rgba out set from storage bs.color: hex
