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

# For each animated part:
# 1. Set the current segment time (<part>[0].t) to 0
# 2. Move segments whose time is 0 (<part>[{t:0}]) to the end of the segment list
# 3. Set every segment time (<part>[].t) to 0

execute if data storage bs:data animation[-1].def[-1].pose run function bs.animation:reset/pose/any
execute if data storage bs:data animation[-1].def[-1].transformation run function bs.animation:reset/transformation/any
execute if data storage bs:data animation[-1].def[-1].position run function bs.animation:reset/position
execute if data storage bs:data animation[-1].def[-1].rotation run function bs.animation:reset/rotation
