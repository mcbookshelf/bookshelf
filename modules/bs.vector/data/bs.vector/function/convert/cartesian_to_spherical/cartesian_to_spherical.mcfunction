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

execute in minecraft:overworld as B5-0-0-0-1 run function bs.vector:convert/cartesian_to_spherical/compute
$execute store result score $vector.cartesian_to_spherical.0 bs.out run data get entity B5-0-0-0-1 Rotation[0] $(scaling)
$execute store result score $vector.cartesian_to_spherical.1 bs.out run data get entity B5-0-0-0-1 Rotation[1] $(scaling)
execute store result score $vector.cartesian_to_spherical.2 bs.out as B5-0-0-0-2 run function bs.vector:length/compute with storage bs:ctx
