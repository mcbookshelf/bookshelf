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

data modify storage bs:in math.atan2.y set value 0.42
data modify storage bs:in math.atan2.x set value -0.7
assert result 26010..26012 run compute default float bs.math:atan2 10000
assert result 149033..149035 run compute default float bs.math:atan2 57295

data modify storage bs:in math.atan2.y set value -0.826
data modify storage bs:in math.atan2.x set value -0.7
assert result -13333..-13331 run compute default float bs.math:atan2 10000
assert result -76389..-76386 run compute default float bs.math:atan2 57295
