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

function bs.geometry:shape/plane

data modify storage bs:out geometry.shape.type set value "sphere"
data modify storage bs:out geometry.shape.parameters set value [0]
execute store result storage bs:out geometry.shape.parameters[0] double 0.001 run scoreboard players get $geometry.shape.sphere.r bs.in

