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

# Modified from https://github.com/Aeldrion/Minecraft-Random
$data modify storage bs:ctx _ set value $(probability)
execute store result score #p bs.ctx run data get storage bs:ctx _ 1000000000

execute unless score #p bs.ctx matches 0..1000000000 run function #bs.log:error { \
  namespace:"bs.random", \
  tag:"geometric", \
  message:'"Probability must be between 0 and 1."', \
  path:"bs.random:distributions/geometric/geometric", \
}

scoreboard players set $random.geometric bs.out 0
function bs.random:distributions/geometric/loop
return run scoreboard players get $random.geometric bs.out
