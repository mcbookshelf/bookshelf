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
# @dummy

function #bs.health:set_max_health {points:10}
execute store result score #r bs.ctx run attribute @s minecraft:max_health get
assert score #r bs.ctx matches 10

function #bs.health:set_max_health {points:20}
execute store result score #r bs.ctx run attribute @s minecraft:max_health get
assert score #r bs.ctx matches 20
