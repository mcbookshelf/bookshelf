# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:ctx _ merge from storage bs:ctx _.pose.left_leg
execute if data storage bs:ctx _.keyframes run function bs.animation:utils/keyframes/3d/bake with storage bs:ctx _.keyframes
execute if data storage bs:ctx _.spline run function bs.animation:utils/spline/3d/bake with storage bs:ctx _.spline
data modify storage bs:ctx _._.pose.left_leg set from storage bs:ctx _.s
data remove storage bs:ctx _.s
