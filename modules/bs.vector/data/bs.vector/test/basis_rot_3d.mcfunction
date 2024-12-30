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

# @batch bs.vector

await entity B5-0-0-0-1

scoreboard players set $vector.basis_rot_3d.pos.0 bs.in 577
scoreboard players set $vector.basis_rot_3d.pos.1 bs.in 577
scoreboard players set $vector.basis_rot_3d.pos.2 bs.in 577
scoreboard players set $vector.basis_rot_3d.rot.0 bs.in -45000
scoreboard players set $vector.basis_rot_3d.rot.1 bs.in -35265

function #bs.vector:basis_rot_3d {scaling:1000}

assert score $vector.basis_rot_3d.0 bs.out matches -1..1
assert score $vector.basis_rot_3d.1 bs.out matches -1..1
assert score $vector.basis_rot_3d.2 bs.out matches 999..1001
