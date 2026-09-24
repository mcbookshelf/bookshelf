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

function #bs.color:hex_to_rgb.in {color:"#F26A3B"}
assert score $color.hex_to_rgb.r bs.out matches 242
assert score $color.hex_to_rgb.g bs.out matches 106
assert score $color.hex_to_rgb.b bs.out matches 59
assert data storage bs.color:hex_to_rgb {out:[0.9490196078f,0.4156862745f,0.231372549f]}

function #bs.color:hex_to_rgb.in {color:"#2AC855"}
assert data storage bs.color:hex_to_rgb {out:[0.1647058824f,0.7843137255f,0.3333333333f]}

function #bs.color:hex_to_rgb.in {color:"#5919C0"}
assert data storage bs.color:hex_to_rgb {out:[0.3490196078f,0.09803921569f,0.7529411765f]}
