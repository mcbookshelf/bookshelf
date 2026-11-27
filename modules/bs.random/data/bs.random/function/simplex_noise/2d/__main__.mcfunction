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

execute store result score #x bs.ctx run compute default integer bs.random:_simplex_noise/x
execute store result score #y bs.ctx run compute default integer bs.random:_simplex_noise/y

execute store result score #s bs.ctx run compute default integer bs.random:_simplex_noise/2d/s
scoreboard players operation #x bs.ctx += #s bs.ctx
scoreboard players operation #y bs.ctx += #s bs.ctx
execute store result score #u bs.ctx run compute default integer bs.random:_simplex_noise/2d/u
execute store result score #v bs.ctx run compute default integer bs.random:_simplex_noise/2d/v

execute store result score #h bs.ctx run data get storage bs.random:simplex_noise in.seed
data modify storage bs.random:simplex_noise out set compute default float bs.random:_simplex_noise/2d/noise
