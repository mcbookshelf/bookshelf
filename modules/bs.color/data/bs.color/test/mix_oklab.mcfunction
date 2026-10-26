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

# The colors are mixed as the eye sees them: red and blue give a purple, black and white a middle gray
data modify storage bs.color:mix_oklab in set value {from:16711680,to:255,ratio:0.5f}
assert result 9196450 run compute default integer bs.color:mix_oklab
data modify storage bs.color:mix_oklab in set value {from:16711680,to:65280,ratio:0.5f}
assert result 13674496 run compute default integer bs.color:mix_oklab
data modify storage bs.color:mix_oklab in set value {from:0,to:16777215,ratio:0.5f}
assert result 6513507 run compute default integer bs.color:mix_oklab
data modify storage bs.color:mix_oklab in set value {from:15886907,to:2803797,ratio:0.25f}
assert result 14059842 run compute default integer bs.color:mix_oklab

# A ratio of 0 gives the first color, and 1 the second one, dark colors included
data modify storage bs.color:mix_oklab in set value {from:15886907,to:2803797,ratio:0f}
assert result 15886907 run compute default integer bs.color:mix_oklab
data modify storage bs.color:mix_oklab in set value {from:15886907,to:2803797,ratio:1f}
assert result 2803797 run compute default integer bs.color:mix_oklab
data modify storage bs.color:mix_oklab in set value {from:330243,to:524800,ratio:0f}
assert result 330243 run compute default integer bs.color:mix_oklab

# A ratio out of range is brought back to it
data modify storage bs.color:mix_oklab in set value {from:15886907,to:2803797,ratio:2f}
assert result 2803797 run compute default integer bs.color:mix_oklab

# The alpha of ARGB integers is mixed on its own
data modify storage bs.color:mix_oklab in set value {from:-2130771968,to:-16776961,ratio:0.5f}
assert result -1064545374 run compute default integer bs.color:mix_oklab
