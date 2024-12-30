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

$scoreboard players set #s bs.ctx $(scaling)

scoreboard players operation $vector.length_squared bs.out = $vector.length_squared.0 bs.in
scoreboard players operation $vector.length_squared bs.out *= $vector.length_squared.0 bs.in
scoreboard players operation #t bs.ctx = $vector.length_squared.1 bs.in
scoreboard players operation #t bs.ctx *= $vector.length_squared.1 bs.in
scoreboard players operation $vector.length_squared bs.out += #t bs.ctx
scoreboard players operation #t bs.ctx = $vector.length_squared.2 bs.in
scoreboard players operation #t bs.ctx *= $vector.length_squared.2 bs.in
scoreboard players operation $vector.length_squared bs.out += #t bs.ctx
return run scoreboard players operation $vector.length_squared bs.out /= #s bs.ctx
