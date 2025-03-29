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

data modify storage bs:data dump.char set string storage bs:data dump.parse 0 1
data modify storage bs:data dump.parse set string storage bs:data dump.parse 1
execute store result storage bs:data dump.cursor int 1 run scoreboard players add #dump.cursor bs.data 1
execute unless score #dump.escape bs.data matches 1 if data storage bs:data dump{char:'"'} run return run function bs.dump:key/parse/terminate with storage bs:data dump
execute store result score #dump.escape bs.data if data storage bs:data dump{char:"\\"}
function bs.dump:key/parse/quoted/double
