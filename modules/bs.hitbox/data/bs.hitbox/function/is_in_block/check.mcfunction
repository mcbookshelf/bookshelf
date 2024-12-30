# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

execute store result score #i bs.ctx run data get storage bs:out hitbox.shape[-1][0] 62500
execute store result score #j bs.ctx run data get storage bs:out hitbox.shape[-1][1] 62500
execute store result score #k bs.ctx run data get storage bs:out hitbox.shape[-1][2] 62500
execute store result score #o bs.ctx run data get storage bs:out hitbox.shape[-1][3] 62500
execute store result score #p bs.ctx run data get storage bs:out hitbox.shape[-1][4] 62500
execute store result score #q bs.ctx run data get storage bs:out hitbox.shape[-1][5] 62500

# offset coordinates if needed
scoreboard players operation #i bs.ctx += #u bs.ctx
scoreboard players operation #o bs.ctx += #u bs.ctx
scoreboard players operation #k bs.ctx += #v bs.ctx
scoreboard players operation #q bs.ctx += #v bs.ctx

execute \
  if score #x bs.ctx >= #i bs.ctx \
  if score #x bs.ctx < #o bs.ctx \
  if score #y bs.ctx >= #j bs.ctx \
  if score #y bs.ctx < #p bs.ctx \
  if score #z bs.ctx >= #k bs.ctx \
  if score #z bs.ctx < #q bs.ctx \
run return 1

data remove storage bs:out hitbox.shape[-1]
execute if data storage bs:out hitbox.shape[0] run return run function bs.hitbox:is_in_block/check
