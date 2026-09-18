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

scoreboard objectives remove bs.anim
scoreboard objectives remove bs.ctx

data remove storage bs.animation: _
data remove storage bs.animation: stack
data remove storage bs.animation:attach in
data remove storage bs.animation:detach in
data remove storage bs.animation:pause in
data remove storage bs.animation:play in
data remove storage bs.animation:reset in
data remove storage bs.animation:rewind in
data remove storage bs.animation:step in
