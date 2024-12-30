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

data modify storage bs:in math.sqrt.x set value 1234.56789
function #bs.math:sqrt
execute store result score #r bs.ctx run data get storage bs:out math.sqrt 100000
assert score #r bs.ctx matches 3513640..3513642

data modify storage bs:in math.sqrt.x set value 98765.56789
function #bs.math:sqrt
execute store result score #r bs.ctx run data get storage bs:out math.sqrt 100000
assert score #r bs.ctx matches 31426988..31426990
