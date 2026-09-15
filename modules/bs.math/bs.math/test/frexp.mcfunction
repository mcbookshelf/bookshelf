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

data modify storage bs:in math.frexp.x set value 5.8
function #bs.math:frexp
assert result 3 run data get storage bs:out math.frexp.e
assert result 725 run data get storage bs:out math.frexp.x 1000

data modify storage bs:in math.frexp.x set value 18238123421.42
function #bs.math:frexp
assert result 35 run data get storage bs:out math.frexp.e
assert result 53079924..53079926 run data get storage bs:out math.frexp.x 100000000
