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

$execute store result score #s bs.ctx run data get storage bs:const health.units[{name:'$(unit)'}].scale 1
execute if score #s bs.ctx matches 1.. run return run data modify storage bs:ctx _.time set compute default integer {type:mul,inputs:[{type:storage,storage:"bs:ctx",path:"_.time"},{type:score,target:{type:fixed,name:"#s"},score:"bs.ctx"}]}

function #bs.log:error { \
  namespace:"bs.health", \
  tag:"time_to_live", \
  message:'"The unit provided is not supported."', \
  path:"bs.health:ttl/register_unit", \
}
