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

scoreboard players remove #counter bs.cid 1
scoreboard players remove @n[predicate=bs.id:cuid_upper,sort=arbitrary,limit=2147483647] bs.cid 1
execute if score #size bs.cid < #counter bs.cid unless entity @n[predicate=bs.id:cuid_equal,sort=arbitrary] run function bs.id:update_cuids/shift
