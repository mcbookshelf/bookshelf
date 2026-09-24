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

function #bs.color:int_to_rgba.in {color:-1829606853}
assert score $color.int_to_rgb.r bs.out matches 242
assert score $color.int_to_rgb.g bs.out matches 106
assert score $color.int_to_rgb.b bs.out matches 59
assert score $color.int_to_rgb.a bs.out matches 146
assert data storage bs.color:int_to_rgba {out:[0.9490196078f,0.4156862745f,0.231372549f,0.5725490196f]}

function #bs.color:int_to_rgba.in {color:975882325}
assert data storage bs.color:int_to_rgba {out:[0.1647058824f,0.7843137255f,0.3333333333f,0.2274509804f]}

function #bs.color:int_to_rgba.in {color:-849798720}
assert data storage bs.color:int_to_rgba {out:[0.3490196078f,0.09803921569f,0.7529411765f,0.8039215686f]}
