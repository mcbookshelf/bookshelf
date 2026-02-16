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

data modify storage bs:data generation[-1]._psr set from storage bs:data generation[-1].psr
data modify storage bs:data generation[-1].psr set value "bs.generation:callbacks/simplex_noise_2d/psr"
data modify storage bs:data generation[-1] merge value { size: 32 }

$data modify storage bs:data generation[-1] merge value $(with)
$data modify storage bs:data generation[-1].cb set value '$(run)'

execute unless data storage bs:data generation[-1].seed store result storage bs:data generation[-1].seed int 1 run random value 1.. bs.generation:simplex_noise_2d
data modify storage bs:data generation[-1].run set value 'function bs.generation:callbacks/simplex_noise_2d/run with storage bs:data generation[-1]'

execute store result score $random.simplex_noise_2d.seed bs.in run data get storage bs:data generation[-1].seed

scoreboard players set #generation.s bs.data 1000
execute store result score #s bs.ctx run data get storage bs:data generation[-1].size
execute store result storage bs:data generation[-1].scalar int 1 run scoreboard players operation #generation.s bs.data /= #s bs.ctx

function bs.generation:callbacks/simplex_noise_2d/run with storage bs:data generation[-1]
