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

data modify storage bs:ctx _ set from storage bs:in string.replace_range
execute store result score #s bs.ctx run data get storage bs:ctx _.start
execute store result score #e bs.ctx run data get storage bs:ctx _.end
execute store result score #l bs.ctx run data get storage bs:ctx _.str

function bs.string:replace_range/split with storage bs:ctx _
function bs.string:replace_range/concat with storage bs:ctx _
