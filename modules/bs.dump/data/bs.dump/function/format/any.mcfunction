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

execute if data storage bs:data dump[-1].var[] run return run function bs.dump:format/array/array
execute if data storage bs:data dump[-1].var{} run return run function bs.dump:format/compound/compound

data modify storage bs:ctx _ set value [[0b],[0s],[0],[0l],[0f],[0d],[""]]
execute store success score #dump.success bs.data run data modify storage bs:ctx _[] append from storage bs:data dump[-1].var
execute if score #dump.success bs.data matches 1 unless data storage bs:ctx _[-1][1] run return run function bs.dump:format/number with storage bs:const dump
execute if score #dump.success bs.data matches 1 run function bs.dump:format/string/string with storage bs:const dump
