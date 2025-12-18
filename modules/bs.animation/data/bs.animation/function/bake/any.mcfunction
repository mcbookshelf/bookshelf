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

execute if data storage bs:ctx _.pose run function bs.animation:bake/pose/any
execute if data storage bs:ctx _.transformation run function bs.animation:bake/transformation/any
execute if data storage bs:ctx _.position run function bs.animation:bake/position
execute if data storage bs:ctx _.rotation run function bs.animation:bake/rotation
execute if data storage bs:ctx _.scale run function bs.animation:bake/scale
