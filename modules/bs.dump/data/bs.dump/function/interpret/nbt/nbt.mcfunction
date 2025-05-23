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

execute store success score #dump.success bs.data run function bs.dump:interpret/nbt/expand/default with storage bs:data dump.stack[-1]
execute if score #dump.success bs.data matches 0 run function bs.dump:interpret/nbt/expand/parse/init
function bs.dump:interpret/nbt/populate with storage bs:data dump.stack[-1]
function bs.dump:format/any
return 1

$data get $(var)
