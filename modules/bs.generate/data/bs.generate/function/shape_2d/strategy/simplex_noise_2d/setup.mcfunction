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

execute store result score $random.simplex_noise_2d.seed bs.in run data get storage bs:data generate._.seed

execute store result score $generate.x bs.data run data get storage bs:data generate._.x
execute store result score $generate.y bs.data run data get storage bs:data generate._.y
execute store result score #generate.w bs.data run data get storage bs:data generate._.w
execute store result score #generate.h bs.data run data get storage bs:data generate._.h
execute store result score #generate.k bs.data run data get storage bs:data generate._.k
execute store result score #generate.i bs.data run data get storage bs:data generate._.limit
