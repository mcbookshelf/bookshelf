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

data remove storage bs.color: a
data modify storage bs.color: r set string storage bs.color:hex_to_rgb in.color 1 3
data modify storage bs.color: g set string storage bs.color:hex_to_rgb in.color 3 5
data modify storage bs.color: b set string storage bs.color:hex_to_rgb in.color 5 7
data modify storage bs.color: a set string storage bs.color:hex_to_rgb in.color 7 9
data modify storage bs.color:hex_to_rgb out set value [0f,0f,0f]
function bs.color:hex_to_rgb/channels with storage bs.color:
execute if data storage bs.color: a run function bs.color:hex_to_rgb/alpha with storage bs.color:
