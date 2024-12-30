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

data modify storage bs:ctx _ set value {scale:1}
$scoreboard players set #i bs.ctx $(length)
$data modify storage bs:ctx _ merge value $(with)
execute store result storage bs:ctx _.scale double .000001 run data get storage bs:ctx _.scale 1000

data modify storage bs:out random.white_noise_mat_1d set value []
execute if score #i bs.ctx matches 1.. run function bs.random:noise/white_noise_mat_1d/loop with storage bs:ctx _
