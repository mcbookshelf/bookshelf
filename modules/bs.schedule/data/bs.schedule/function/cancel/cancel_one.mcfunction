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

# Find the last element of the queue with the given data.
$data modify storage bs:ctx _ set from storage bs:data schedule.queue[$(with)]
execute store success score #i bs.ctx run function bs.schedule:cancel/remove_one with storage bs:ctx _
function #bs.log:info {namespace:"bs.schedule", tag:"cancel_one", path:"#bs.schedule:cancel_one", message:'["Canceled ",{"score":{"name":"#i","objective":"bs.ctx"}}," command."]'}
