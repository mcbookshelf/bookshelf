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

# Helper function for reduce test: multiply accumulator by value
execute store result score #a bs.ctx run data get storage bs:lambda collection.value
execute store result score #b bs.ctx run data get storage bs:lambda collection.accumulator
scoreboard players operation #a bs.ctx *= #b bs.ctx
execute store result storage bs:lambda collection.result int 1 run scoreboard players get #a bs.ctx
