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
$data modify storage bs:ctx _ set value {n:$(trials),p:$(probability)}
execute store result score #n bs.ctx run data get storage bs:ctx _.n
execute store result score #p bs.ctx run data get storage bs:ctx _.p 1000000000

execute unless score #n bs.ctx matches 1..1000 run function #bs.log:error { \
  namespace:"bs.random", \
  tag:"binomial", \
  message:'"Trials must be between 1 and 1000."', \
  path:"bs.random:distributions/binomial/binomial", \
}

execute unless score #p bs.ctx matches 0..1000000000 run function #bs.log:error { \
  namespace:"bs.random", \
  tag:"binomial", \
  message:'"Probability must be between 0 and 1."', \
  path:"bs.random:distributions/binomial/binomial", \
}

scoreboard players set $random.binomial bs.out 0
execute if score #n bs.ctx matches 1..1000 if score #p bs.ctx matches 1..1000000000 run function bs.random:distributions/binomial/loop
return run scoreboard players get $random.binomial bs.out
