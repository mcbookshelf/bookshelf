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

execute if predicate bs.raycast:face/east positioned ~1 ~ ~ run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
execute if predicate bs.raycast:face/west positioned ~-1 ~ ~ run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
execute if predicate bs.raycast:face/top positioned ~ ~1 ~ run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
execute if predicate bs.raycast:face/bottom positioned ~ ~-1 ~ run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
execute if predicate bs.raycast:face/south positioned ~ ~ ~1 run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
execute if predicate bs.raycast:face/north positioned ~ ~ ~-1 run return run function bs.view:utils/aimed with storage bs.view:at_block_placement in
return fail
