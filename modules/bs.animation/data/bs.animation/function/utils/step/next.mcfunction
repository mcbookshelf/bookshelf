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

execute store result score #t bs.ctx run data get storage bs:ctx _[0].t
execute store result score #d bs.ctx run data get storage bs:ctx _[0].d 1000
execute store result score #s bs.ctx run data get storage bs:data animation[-1].def[-1].step 1000
execute store result storage bs:ctx _[0].t int 1 run scoreboard players operation #t bs.ctx += #s bs.ctx
execute if score #t bs.ctx >= #d bs.ctx run return run function bs.animation:utils/step/rotate/left
execute if score #t bs.ctx matches ..-1 run return run function bs.animation:utils/step/rotate/right
return 1
