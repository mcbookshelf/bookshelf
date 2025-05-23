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

execute store result score #r bs.ctx run function #bs.health:get_health {scale:1}
assert score #r bs.ctx matches 20

function #bs.health:set_health {points:10}
function #bs.health:add_health {points:5}
execute store result score #r bs.ctx run function #bs.health:get_health {scale:1}
assert score #r bs.ctx matches 15
