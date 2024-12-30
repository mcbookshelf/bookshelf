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

# @batch bs.vector

await entity B5-0-0-0-2

scoreboard players set $vector.length.0 bs.in 37216
scoreboard players set $vector.length.1 bs.in 3383
scoreboard players set $vector.length.2 bs.in 19172

function #bs.vector:length

assert score $vector.length bs.out matches 42000
