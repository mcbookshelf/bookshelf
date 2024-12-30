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

execute if data storage bs:out block{group:0} run return 0

$data modify storage bs:ctx _ set value {i:$(properties)}
function bs.block:transform/lookup_group with storage bs:out block
function bs.block:transform/keep_properties/recurse/next with storage bs:ctx _.i[-1]

data modify storage bs:out block.properties set from storage bs:ctx _.p
data modify storage bs:out block._ set from storage bs:ctx _.s
