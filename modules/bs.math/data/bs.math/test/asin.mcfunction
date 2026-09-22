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

data modify storage bs:in math.asin.x set value 0.42
assert result 4333..4335 run compute default float bs.math:asin 10000
assert result 24833..24835 run compute default float bs.math:asin 57295

data modify storage bs:in math.asin.x set value -0.826
assert result -9720..-9718 run compute default float bs.math:asin 10000
assert result -55690..-55688 run compute default float bs.math:asin 57295
