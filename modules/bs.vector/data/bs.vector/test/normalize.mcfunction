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

await entity B5-0-0-0-1

scoreboard players set $vector.normalize.0 bs.in 37216
scoreboard players set $vector.normalize.1 bs.in 3383
scoreboard players set $vector.normalize.2 bs.in 19172

function #bs.vector:normalize {scale:1000}

assert score $vector.normalize.0 bs.out matches 885..887
assert score $vector.normalize.1 bs.out matches 79..81
assert score $vector.normalize.2 bs.out matches 455..457
