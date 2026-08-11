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

assert result 15886907 run function #bs.color:hex_to_int {color:"#F26A3B"}
assert data storage bs:out color{hex_to_int:15886907}
assert score $color.hex_to_int bs.out matches 15886907

assert result 2803797 run function #bs.color:hex_to_int {color:"#2AC855"}

assert result 5839296 run function #bs.color:hex_to_int {color:"#5919C0"}
