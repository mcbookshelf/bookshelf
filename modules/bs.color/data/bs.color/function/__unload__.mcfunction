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

scoreboard objectives remove bs.const
scoreboard objectives remove bs.ctx
scoreboard objectives remove bs.out

data remove storage bs.color: hex_chars
data remove storage bs.color: hex_values
data remove storage bs.color: channel
data remove storage bs.color: channel_h
data remove storage bs.color: color
data remove storage bs.color: int
data remove storage bs.color: rgb
data remove storage bs.color: hex

data remove storage bs.color:int_to_hex out
data remove storage bs.color:int_to_hex_rgba out
data remove storage bs.color:int_to_rgb out
data remove storage bs.color:int_to_rgba out

data remove storage bs.color:hex_to_int out
data remove storage bs.color:hex_to_rgb out

data remove storage bs.color:rgb_to_hex out
data remove storage bs.color:rgb_to_int out
