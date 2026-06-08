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

execute store success score #s bs.ctx run data modify storage bs:out collection.value[0] set from storage bs:ctx _.searched
# If we failed to overwrite the value with the searched value, so both are equal and the collection contains the value
execute if score #s bs.ctx matches 0 run return 0

# Else, we continue the search
data remove storage bs:out collection.value[0]
execute if data storage bs:out collection.value[0] run return run function bs.collection:contains/contains_rec

return fail
