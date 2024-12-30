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

scoreboard players operation $vector.dot_product bs.out = $vector.dot_product.u.0 bs.in
scoreboard players operation $vector.dot_product bs.out *= $vector.dot_product.v.0 bs.in
scoreboard players operation #t bs.ctx = $vector.dot_product.u.1 bs.in
scoreboard players operation #t bs.ctx *= $vector.dot_product.v.1 bs.in
scoreboard players operation $vector.dot_product bs.out += #t bs.ctx
scoreboard players operation #t bs.ctx = $vector.dot_product.u.2 bs.in
scoreboard players operation #t bs.ctx *= $vector.dot_product.v.2 bs.in
scoreboard players operation $vector.dot_product bs.out += #t bs.ctx
return run scoreboard players operation $vector.dot_product bs.out /= #s bs.ctx
