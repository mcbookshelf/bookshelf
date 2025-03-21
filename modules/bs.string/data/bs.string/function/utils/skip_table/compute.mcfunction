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

execute store result score #p bs.ctx store result storage bs:ctx y int 1 run data get storage bs:ctx _.substr
data modify storage bs:ctx _.char set string storage bs:ctx _.substr 0 1
data modify storage bs:ctx _.substr set string storage bs:ctx _.substr 1
execute unless score #p bs.ctx matches 1 run function bs.string:utils/skip_table/loop with storage bs:ctx _
