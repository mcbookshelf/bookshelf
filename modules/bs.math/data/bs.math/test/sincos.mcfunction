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

scoreboard players set $math.sincos.x bs.in 6442
function #bs.math:sincos
assert score $math.sincos.cos bs.out matches 430..432
assert score $math.sincos.sin bs.out matches 900..902

scoreboard players set $math.sincos.x bs.in -21513
function #bs.math:sincos
assert score $math.sincos.cos bs.out matches -818..-816
assert score $math.sincos.sin bs.out matches 574..576
