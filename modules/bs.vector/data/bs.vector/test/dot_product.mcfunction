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

scoreboard players set $vector.dot_product.u.0 bs.in 24
scoreboard players set $vector.dot_product.u.1 bs.in 35
scoreboard players set $vector.dot_product.u.2 bs.in 42

scoreboard players set $vector.dot_product.v.0 bs.in 35
scoreboard players set $vector.dot_product.v.1 bs.in 42
scoreboard players set $vector.dot_product.v.2 bs.in 45

function #bs.vector:dot_product {scaling:10}

assert score $vector.dot_product bs.out matches 420
