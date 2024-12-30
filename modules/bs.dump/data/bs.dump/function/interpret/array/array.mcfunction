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

execute store result score #dump.count bs.data if data storage bs:data dump[-1].var[]

execute if score #dump.count bs.data matches 0 run return run function bs.dump:format/array/empty
execute if score #dump.count bs.data matches ..3 \
  unless data storage bs:data dump[-1].var[][] \
  unless data storage bs:data dump[-1].var[{}] \
  run return run function bs.dump:interpret/array/compact/compact

function bs.dump:format/bracket/open with storage bs:const dump
function bs.dump:interpret/array/loop
data modify storage bs:out dump append value '"\\n"'
data modify storage bs:out dump append from storage bs:data dump[].indent
data remove storage bs:out dump[-1]
function bs.dump:format/bracket/close with storage bs:const dump
