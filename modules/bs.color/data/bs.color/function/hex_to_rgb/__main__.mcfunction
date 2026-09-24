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

data modify storage bs.color: channel_h.r set string storage bs.color:hex_to_rgb in.color 1 3
data modify storage bs.color: channel_h.g set string storage bs.color:hex_to_rgb in.color 3 5
data modify storage bs.color: channel_h.b set string storage bs.color:hex_to_rgb in.color 5 7
data remove storage bs.color: channel_h.a
data modify storage bs.color: channel_h.a set string storage bs.color:hex_to_rgb in.color 7 9

execute unless data storage bs.color: channel_h.a run function bs.color:utils/hexes_to_rgb with storage bs.color: channel_h
execute if data storage bs.color: channel_h.a run function bs.color:utils/hexes_a_to_rgba with storage bs.color: channel_h
data modify storage bs.color:hex_to_rgb out set from storage bs.color: rgb
