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

data modify storage bs.bitwise:or in set value {a:-9,b:57}
assert result -1 run compute default integer bs.bitwise:or

data modify storage bs.bitwise:or in set value {a:1234567890,b:123456}
assert result 1234690770 run compute default integer bs.bitwise:or

data modify storage bs.bitwise:or in set value {a:-2147483648,b:1}
assert result -2147483647 run compute default integer bs.bitwise:or

data modify storage bs.bitwise:or in set value {a:2147483647,b:-2147483648}
assert result -1 run compute default integer bs.bitwise:or
