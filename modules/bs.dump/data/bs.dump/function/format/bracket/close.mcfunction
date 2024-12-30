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

execute store result score #dump.depth bs.data if data storage bs:data dump[]
scoreboard players operation #dump.depth bs.data %= 3 bs.const

$execute if score #dump.depth bs.data matches 0 run data modify storage bs:out dump append value '{"text":"]","color":"$(bracket_1)"}'
$execute if score #dump.depth bs.data matches 1 run data modify storage bs:out dump append value '{"text":"]","color":"$(bracket_2)"}'
$execute if score #dump.depth bs.data matches 2 run data modify storage bs:out dump append value '{"text":"]","color":"$(bracket_3)"}'
