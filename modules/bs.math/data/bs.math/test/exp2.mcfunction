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

data modify storage bs:in math.exp2.x set value 3.0
function #bs.math:exp2
execute store result score #r bs.ctx run data get storage bs:out math.exp2 10000
assert score #r bs.ctx matches 80000..80000

data modify storage bs:in math.exp2.x set value 7.25
function #bs.math:exp2
execute store result score #r bs.ctx run data get storage bs:out math.exp2 10000
assert score #r bs.ctx matches 1522184..1522186
