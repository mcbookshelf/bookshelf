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

execute if data storage bs:data animation[-1].def[-1].pose run function bs.animation:step/pose/any
execute if data storage bs:data animation[-1].def[-1].transformation run function bs.animation:step/transformation/any
execute if data storage bs:data animation[-1].def[-1].position run function bs.animation:step/position
execute if data storage bs:data animation[-1].def[-1].rotation run function bs.animation:step/rotation

execute unless data storage bs:data animation[-1].def[-1].continue run function bs.animation:utils/stop
data remove storage bs:data animation[-1].def[-1].continue
