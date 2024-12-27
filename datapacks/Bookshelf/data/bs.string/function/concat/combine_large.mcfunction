# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#concat
# ------------------------------------------------------------------------------------------------------------

$execute if score #n bs.ctx matches ..99 run function bs.string:concat/combine/$(n)
execute if score #n bs.ctx matches 100.. run function bs.string:concat/combine/100

#loop
scoreboard players remove #n bs.ctx 100
execute if score #n bs.ctx matches ..0 run return run return 0
execute store result storage bs:ctx _.n int 1 run scoreboard players get #n bs.ctx
function bs.string:concat/combine_large with storage bs:ctx _