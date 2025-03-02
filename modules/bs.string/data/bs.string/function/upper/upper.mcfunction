# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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
#setup
data modify storage bs:ctx _.st set from storage bs:in string.upper.str
execute store result score #c bs.ctx store result score #n bs.ctx run data get storage bs:in string.upper.str
data modify storage bs:ctx _.ch set string storage bs:ctx _.st 0 1
data remove storage bs:ctx _.list

function bs.string:upper/loop with storage bs:ctx _

function bs.string:concat/run

data modify storage bs:out string.upper set from storage bs:ctx _.s.1
