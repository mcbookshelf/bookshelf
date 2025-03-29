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

data modify entity B5-0-0-0-2 text set value {storage:"bs:data",nbt:"dump.stack[-1].var"}
data modify storage bs:data dump.escape._ set string entity B5-0-0-0-2 text
data modify entity B5-0-0-0-2 text set value {storage:"bs:data",nbt:"dump.escape"}
data modify storage bs:data dump.escape._ set string entity B5-0-0-0-2 text
data modify storage bs:data dump.char set string storage bs:data dump.escape._ 3 4
data modify storage bs:data dump.value set string storage bs:data dump.escape._ 4 -2
execute if data storage bs:data dump{char:"'"} run function bs.dump:format/collapse/escape with storage bs:data dump
function bs.dump:format/collapse/event with storage bs:data dump
