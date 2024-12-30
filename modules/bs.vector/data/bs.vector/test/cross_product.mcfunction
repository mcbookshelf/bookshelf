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

scoreboard players set $vector.cross_product.u.0 bs.in 4
scoreboard players set $vector.cross_product.u.1 bs.in 2
scoreboard players set $vector.cross_product.u.2 bs.in 5

scoreboard players set $vector.cross_product.v.0 bs.in 1
scoreboard players set $vector.cross_product.v.1 bs.in 3
scoreboard players set $vector.cross_product.v.2 bs.in 9

function #bs.vector:cross_product {scaling:1}

assert score $vector.cross_product.0 bs.out matches 3
assert score $vector.cross_product.1 bs.out matches -31
assert score $vector.cross_product.2 bs.out matches 10
