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

execute store result score $generation.x bs.lambda run data get storage bs:data generation._.x
execute store result score $generation.y bs.lambda run data get storage bs:data generation._.y
execute store result score #generation.w bs.data run data get storage bs:data generation._.w
execute store result score #generation.h bs.data run data get storage bs:data generation._.h
execute store result score #generation.i bs.data run data get storage bs:data generation._.limit
