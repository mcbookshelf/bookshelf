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

# out.0 = u.1 * v.2 - u.2 * v.1
scoreboard players operation $vector.cross_product.0 bs.out = $vector.cross_product.u.1 bs.in
scoreboard players operation $vector.cross_product.0 bs.out *= $vector.cross_product.v.2 bs.in
scoreboard players operation #t bs.ctx = $vector.cross_product.u.2 bs.in
scoreboard players operation #t bs.ctx *= $vector.cross_product.v.1 bs.in
scoreboard players operation $vector.cross_product.0 bs.out -= #t bs.ctx
scoreboard players operation $vector.cross_product.0 bs.out /= #s bs.ctx

# out.1 = u.2 * v.0 - u.0 * v.2
scoreboard players operation $vector.cross_product.1 bs.out = $vector.cross_product.u.2 bs.in
scoreboard players operation $vector.cross_product.1 bs.out *= $vector.cross_product.v.0 bs.in
scoreboard players operation #t bs.ctx = $vector.cross_product.u.0 bs.in
scoreboard players operation #t bs.ctx *= $vector.cross_product.v.2 bs.in
scoreboard players operation $vector.cross_product.1 bs.out -= #t bs.ctx
scoreboard players operation $vector.cross_product.1 bs.out /= #s bs.ctx

# out.2 = u.0 * v.1 - u.1 * v.0
scoreboard players operation $vector.cross_product.2 bs.out = $vector.cross_product.u.0 bs.in
scoreboard players operation $vector.cross_product.2 bs.out *= $vector.cross_product.v.1 bs.in
scoreboard players operation #t bs.ctx = $vector.cross_product.u.1 bs.in
scoreboard players operation #t bs.ctx *= $vector.cross_product.v.0 bs.in
scoreboard players operation $vector.cross_product.2 bs.out -= #t bs.ctx
scoreboard players operation $vector.cross_product.2 bs.out /= #s bs.ctx
