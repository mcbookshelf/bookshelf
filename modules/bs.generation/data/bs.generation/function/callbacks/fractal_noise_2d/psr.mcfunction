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

execute store result score $random.fractal_noise_2d.seed bs.in run data get storage bs:data generation[-1].seed
execute store result score $random.fractal_noise_2d.octaves bs.in run data get storage bs:data generation[-1].octaves
execute store result score $random.fractal_noise_2d.persistence bs.in run data get storage bs:data generation[-1].persistence 1000
execute store result score $random.fractal_noise_2d.lacunarity bs.in run data get storage bs:data generation[-1].lacunarity 1000
execute store result score #generation.s bs.data run data get storage bs:data generation[-1].scalar

$function $(_psr) with storage bs:data generation[-1]
