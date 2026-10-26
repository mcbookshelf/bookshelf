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

$execute unless function bs.animation:attach/type/$(type) run return fail
data modify storage bs.animation: _.run set from storage bs.animation:attach in.run
data modify storage bs.animation: _.id set from storage bs.animation:attach in.id
data modify storage bs.animation: _.p set from storage bs.animation: _.p0
data modify storage bs.animation: _.d set from storage bs.animation: _.d0
return run data modify entity @s data."bs.animation" append from storage bs.animation: _
