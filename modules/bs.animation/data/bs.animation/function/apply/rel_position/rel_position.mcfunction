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

execute unless data storage bs.animation: stack[-1]._[0]._ run function bs.animation:apply/rel_position/init

data modify storage bs.animation: _ set from storage bs.animation: stack[-1]._[0]._
data modify storage bs.animation: _.rx set compute default float bs.animation:eval/0
data modify storage bs.animation: _.ry set compute default float bs.animation:eval/1
data modify storage bs.animation: _.rz set compute default float bs.animation:eval/2

function bs.animation:apply/rel_position/run with storage bs.animation: _
