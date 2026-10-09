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

data modify storage bs.color: a set value "00"
data modify storage bs.color: r set string storage bs.color:hex_to_int in.color 1 3
data modify storage bs.color: g set string storage bs.color:hex_to_int in.color 3 5
data modify storage bs.color: b set string storage bs.color:hex_to_int in.color 5 7
data modify storage bs.color: a set string storage bs.color:hex_to_int in.color 7 9
function bs.color:hex_to_int/get_bytes with storage bs.color:
return run execute store result storage bs.color:hex_to_int out int 1 run compute default integer {type:"add",inputs:[{type:"storage",storage:"bs.color:",path:"b"},{type:"mul",inputs:[{type:"storage",storage:"bs.color:",path:"g"},256]},{type:"mul",inputs:[{type:"storage",storage:"bs.color:",path:"r"},65536]},{type:"mul",inputs:[{type:"add",inputs:[{type:"floor_mod",left:{type:"add",inputs:[{type:"storage",storage:"bs.color:",path:"a"},128]},right:256},-128]},16777216]}]}
