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

function #bs.color:hex_to_rgb {color:"#F26A3B"}
assert score $color.hex_to_rgb.r bs.out matches 242
assert score $color.hex_to_rgb.g bs.out matches 106
assert score $color.hex_to_rgb.b bs.out matches 59
assert data storage bs:out color{hex_to_rgb:[242,106,59]}

function #bs.color:hex_to_rgb {color:"#2AC855"}
assert data storage bs:out color{hex_to_rgb:[42,200,85]}

function #bs.color:hex_to_rgb {color:"#5919C0"}
assert data storage bs:out color{hex_to_rgb:[89,25,192]}
