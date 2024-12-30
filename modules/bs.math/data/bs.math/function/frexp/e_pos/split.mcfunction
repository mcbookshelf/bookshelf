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

execute store result score #x bs.ctx run data get storage bs:ctx x .000000000000000000000211758236813575084767080625169910490512847900390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run function bs.math:frexp/e_pos/range_1
execute store result score #x bs.ctx run data get storage bs:ctx x .0000000000009094947017729282379150390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run function bs.math:frexp/e_pos/range_2
execute store result score #x bs.ctx run data get storage bs:ctx x .00390625
execute unless score #x bs.ctx matches -8388607..8388607 run return run function bs.math:frexp/e_pos/range_3
function bs.math:frexp/e_pos/range_4
