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

# Each channel is taken between the two colors
data modify storage bs.color:mix in set value {from:16711680,to:255,ratio:0.5f}
assert result 8388736 run compute default integer bs.color:mix
data modify storage bs.color:mix in set value {from:16711680,to:255,ratio:0.25f}
assert result 12517440 run compute default integer bs.color:mix

# A ratio of 0 gives the first color, and 1 the second one
data modify storage bs.color:mix in set value {from:15886907,to:2803797,ratio:0f}
assert result 15886907 run compute default integer bs.color:mix
data modify storage bs.color:mix in set value {from:15886907,to:2803797,ratio:1f}
assert result 2803797 run compute default integer bs.color:mix

# A ratio out of range is brought back to it
data modify storage bs.color:mix in set value {from:15886907,to:2803797,ratio:2f}
assert result 2803797 run compute default integer bs.color:mix
data modify storage bs.color:mix in set value {from:15886907,to:2803797,ratio:-1f}
assert result 15886907 run compute default integer bs.color:mix

# The alpha of ARGB integers is mixed too
data modify storage bs.color:mix in set value {from:16711680,to:-16776961,ratio:0.5f}
assert result -2139094912 run compute default integer bs.color:mix
data modify storage bs.color:mix in set value {from:-1829606853,to:-1829606853,ratio:0.3f}
assert result -1829606853 run compute default integer bs.color:mix
