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

data modify storage bs:ctx _ set from storage bs:in string.insert
execute store result score #s bs.ctx run data get storage bs:in string.insert.start
execute store result score #e bs.ctx run data get storage bs:in string.insert.end
execute store result score #l bs.ctx run data get storage bs:in string.insert.str

data modify storage bs:ctx _.s.2 set string storage bs:in string.insert.substr
function bs.string:insert/macro_loader with storage bs:ctx _
function bs.string:concat/combine/2c with storage bs:ctx _.s

data modify storage bs:out string.insert set from storage bs:ctx _.s.1
