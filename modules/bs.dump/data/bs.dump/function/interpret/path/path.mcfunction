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

execute store success score #dump.success bs.data run function bs.dump:interpret/path/expand/guard with storage bs:data dump[-1]
execute if score #dump.success bs.data matches 0 run function bs.dump:interpret/path/expand/parse/init with storage bs:ctx
execute if score #dump.success bs.data matches 1 run data modify storage bs:data dump[-1].expand set value 2

function bs.dump:interpret/path/populate with storage bs:data dump[-1]
return run function bs.dump:format/any

$data get $(var)
