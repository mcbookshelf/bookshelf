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

data modify storage bs:dump output append value "\n"
data modify storage bs:dump output append from storage bs:dump stack[].indent

function bs.dump:key/get
function bs.dump:key/stack with storage bs:dump stack[-1]
function bs.dump:format/compound/key with storage bs:const dump
function bs.dump:interpret/any
function bs.dump:key/unstack with storage bs:dump stack[-2]

execute store result score #dump.count bs.data run data get storage bs:dump stack[-1].var
execute if score #dump.count bs.data matches 1.. run data modify storage bs:dump output append value ", "
execute if score #dump.count bs.data matches 1.. run function bs.dump:interpret/compound/loop
