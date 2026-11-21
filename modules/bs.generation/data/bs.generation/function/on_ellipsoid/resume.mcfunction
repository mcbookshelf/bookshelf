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

execute store result score #generation.end bs.data run compute default integer bs.generation:_on_ellipsoid/end
execute store result storage bs.generation: tasks[0].rewind_i int 1 run compute default integer {type:"sub",left:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.end"}},right:{type:"score",score:"bs.data",target:{type:"fixed",name:"#generation.i"}}}
function bs.generation:on_ellipsoid/step
execute if score #generation.paused bs.data matches 1 run return fail
function bs.generation:on_ellipsoid/rewind with storage bs.generation: tasks[0]
