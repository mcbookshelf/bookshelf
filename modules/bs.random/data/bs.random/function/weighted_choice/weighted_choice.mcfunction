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

scoreboard players set #i bs.ctx -1
data modify storage bs:ctx _ set value {pools:[{rolls:1,entries:[]}]}
data modify storage bs:ctx _.options set from storage bs:in random.weighted_choice.options
data modify storage bs:ctx _.weights set from storage bs:in random.weighted_choice.weights
execute if data storage bs:ctx _.options[-1] run function bs.random:weighted_choice/loop
return run function bs.random:weighted_choice/run with storage bs:ctx
