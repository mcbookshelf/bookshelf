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

execute unless data storage bs:in block.fill_block.mode run data modify storage bs:in block.fill_block.mode set value "replace"
execute if data storage bs:in block.fill_block.filter run return run function bs.block:fill/utils/fill_filtered_block with storage bs:in block.fill_block
return run function bs.block:fill/utils/fill_block with storage bs:in block.fill_block
