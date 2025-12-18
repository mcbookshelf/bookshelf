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

execute store result score #s bs.ctx run data get storage bs:data animation._[-1].step 1000
function bs.animation:step/any
execute store result score #t bs.ctx store result storage bs:data animation._[-1].tick int 1 run function bs.animation:utils/process/schedule with storage bs:data animation._[-1]
