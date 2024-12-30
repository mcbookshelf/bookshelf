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

$data modify storage bs:ctx _.filter set from storage bs:ctx _.sets[{type:"$(type)"}]
execute if data storage bs:ctx _.filter run data modify storage bs:ctx _.filter.attr set from storage bs:ctx _.attrs[0]
execute if data storage bs:ctx _.filter run function bs.block:transform/type_mappings/filter_set with storage bs:ctx _.filter
