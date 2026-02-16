# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

$function bs.block:fill/type/mode/$(_) with storage bs:in block.fill_type

scoreboard players remove #k bs.ctx 1
execute if score #k bs.ctx matches 0.. positioned ~ ~ ~1 run function bs.block:fill/type/z with storage bs:in block.fill_type
