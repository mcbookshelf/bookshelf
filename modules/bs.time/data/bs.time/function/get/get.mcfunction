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

data modify storage bs:data time.full set string block -30000000 0 1605 LastOutput 10 18
data modify storage bs:data time.hours set string storage bs:data time.full 0 2
data modify storage bs:data time.minutes set string storage bs:data time.full 3 5
data modify storage bs:data time.seconds set string storage bs:data time.full 6 8

function bs.time:get/cast with storage bs:data time
