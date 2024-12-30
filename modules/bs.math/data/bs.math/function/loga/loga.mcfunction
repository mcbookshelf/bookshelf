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

data modify storage bs:ctx x set from storage bs:in math.loga.a
function bs.math:log2/run

scoreboard players set #a bs.ctx 2000000000
execute store result score #b bs.ctx run data get storage bs:ctx x 20000
execute store result storage bs:ctx y double 1 run scoreboard players operation #a bs.ctx /= #b bs.ctx

data modify storage bs:ctx x set from storage bs:in math.loga.x
function bs.math:log2/run
function bs.math:loga/mul with storage bs:ctx
