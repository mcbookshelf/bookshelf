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

execute if score #generation.i bs.data matches 8.. if score #generation.batch bs.data matches 8.. run return run function bs.generation:on_ellipsoid/step/8 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 7.. if score #generation.batch bs.data matches 7.. run return run function bs.generation:on_ellipsoid/step/7 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 6.. if score #generation.batch bs.data matches 6.. run return run function bs.generation:on_ellipsoid/step/6 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 5.. if score #generation.batch bs.data matches 5.. run return run function bs.generation:on_ellipsoid/step/5 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 4.. if score #generation.batch bs.data matches 4.. run return run function bs.generation:on_ellipsoid/step/4 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 3.. if score #generation.batch bs.data matches 3.. run return run function bs.generation:on_ellipsoid/step/3 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 2.. if score #generation.batch bs.data matches 2.. run return run function bs.generation:on_ellipsoid/step/2 with storage bs.generation: tasks[0]
execute if score #generation.i bs.data matches 1.. if score #generation.batch bs.data matches 1.. run return run function bs.generation:on_ellipsoid/step/1 with storage bs.generation: tasks[0]
function bs.generation:on_ellipsoid/pause
