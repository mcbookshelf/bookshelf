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

data modify storage bs:in log.hours set string storage bs:data log.time 0 2
data modify storage bs:in log.minutes set string storage bs:data log.time 3 5
data modify storage bs:in log.seconds set string storage bs:data log.time 6 8

execute store result storage bs:in log.gametime int 1 store result score #t bs.ctx run time query gametime
execute store result storage bs:in log.ticks int .99999999999 run scoreboard players operation #t bs.ctx -= #log.gametime bs.data
execute if score #t bs.ctx matches ..10 run function bs.log:time/ticks/format with storage bs:in log
execute if score #t bs.ctx matches 11.. run function bs.log:time/ticks/stringify with storage bs:in log
