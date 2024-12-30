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

# Set the executor to the target or the source
execute if data storage bs:ctx _{executor: "target"} run data modify storage bs:ctx _.executor set value "@s"
execute if data storage bs:ctx _{executor: "source"} run data modify storage bs:ctx _.executor set value "@p[distance=0,tag=bs.interaction.source]"
# The executor should be interpreted now only if lazy is set to false
execute if data storage bs:ctx _.executor{lazy: false} run function bs.interaction:register/utils/executor/interpret with storage bs:ctx _.executor
# If executor is still an object, replace the executor by the internal selector
data modify storage bs:ctx _.executor set from storage bs:ctx _.executor.selector
# Check if the executor is a valid selector
execute store success score #s bs.ctx run function bs.interaction:register/utils/executor/check with storage bs:ctx _
return run scoreboard players get #s bs.ctx
