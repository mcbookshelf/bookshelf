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

execute unless data storage bs:in block.set_type.mode run data modify storage bs:in block.set_type.mode set value "replace"
function bs.block:get/get_block
function #bs.block:replace_type with storage bs:in block.set_type
data modify storage bs:out block.mode set from storage bs:in block.set_type.mode
return run function bs.block:set/run with storage bs:out block
