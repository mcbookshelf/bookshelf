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

data modify storage bs:in math.ldexp set value {x:.652,e:-3}
function #bs.math:ldexp
assert result 814..816 run data get storage bs:out math.ldexp 10000

data modify storage bs:in math.ldexp set value {x:-.725,e:3}
function #bs.math:ldexp
assert result -6 run data get storage bs:out math.ldexp

data modify storage bs:in math.ldexp set value {x:.85,e:11}
function #bs.math:ldexp
assert result 17407999..17408001 run data get storage bs:out math.ldexp 10000
