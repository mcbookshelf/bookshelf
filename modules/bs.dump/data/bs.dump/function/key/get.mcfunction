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

data modify entity B5-0-0-0-2 text set value '{"storage":"bs:data","nbt":"dump[-1].var"}'
function bs.dump:key/unquote with entity B5-0-0-0-2

data modify storage bs:ctx _ set string storage bs:data dump[-1].key 1 2
execute store result storage bs:ctx x int 1 run scoreboard players set #dump.cursor bs.data 2
execute store result storage bs:ctx y int 1 run scoreboard players add #dump.cursor bs.data 1
execute if data storage bs:ctx {_:'"'} run return run function bs.dump:key/parse/quoted/double with storage bs:ctx
execute if data storage bs:ctx {_:"'"} run return run function bs.dump:key/parse/quoted/single with storage bs:ctx
function bs.dump:key/parse/unquoted with storage bs:ctx
