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

data modify storage bs:data dump.value set from storage bs:data dump.stack[-1].var
execute if data storage bs:data dump.value[] run return run function bs.dump:format/array/array
execute if data storage bs:data dump{value:[]} run return run function bs.dump:format/array/empty
execute if data storage bs:data dump.value{} run return run function bs.dump:format/compound/compound

execute store success score #dump.success bs.data run data modify storage bs:data dump.value set string storage bs:data dump.stack[-1].var
execute if score #dump.success bs.data matches 1 run return run function bs.dump:format/number with storage bs:const dump
function bs.dump:format/string with storage bs:const dump
