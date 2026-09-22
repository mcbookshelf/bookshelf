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

data modify storage bs:in math.acos.x set value 0.42
assert result 11372..11374 run compute default float bs.math:acos 10000
assert result 65163..65165 run compute default float bs.math:acos 57295

data modify storage bs:in math.acos.x set value -0.826
assert result 25426..25428 run compute default float bs.math:acos 10000
assert result 14567..14569 run compute default float bs.math:acos 57295
