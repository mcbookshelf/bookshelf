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

scoreboard players set $random.simplex_noise_2d.x bs.in 28656
scoreboard players set $random.simplex_noise_2d.y bs.in 1203
scoreboard players set $random.simplex_noise_2d.seed bs.in 5865932
function #bs.random:simplex_noise_2d
assert score $random.simplex_noise_2d bs.out matches 170

scoreboard players set $random.simplex_noise_2d.x bs.in 15589
scoreboard players set $random.simplex_noise_2d.y bs.in 812
scoreboard players set $random.simplex_noise_2d.seed bs.in 57678
function #bs.random:simplex_noise_2d
assert score $random.simplex_noise_2d bs.out matches 279

scoreboard players set $random.simplex_noise_2d.x bs.in 420
scoreboard players set $random.simplex_noise_2d.y bs.in 5123
scoreboard players set $random.simplex_noise_2d.seed bs.in 1
function #bs.random:simplex_noise_2d
assert score $random.simplex_noise_2d bs.out matches -612

scoreboard players set $random.simplex_noise_2d.x bs.in 1000
scoreboard players set $random.simplex_noise_2d.y bs.in 1000
scoreboard players set $random.simplex_noise_2d.seed bs.in 123456789
function #bs.random:simplex_noise_2d
assert score $random.simplex_noise_2d bs.out matches -473
