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

function #bs.color:rgb_to_hex.in {color:[0.9490196078f,0.4156862745f,0.231372549f]}
assert data storage bs.color:rgb_to_hex {out:"#f26a3b"}

function #bs.color:rgb_to_hex.in {color:[0.1647058824f,0.7843137255f,0.3333333333f]}
assert data storage bs.color:rgb_to_hex {out:"#2ac855"}

function #bs.color:rgb_to_hex.in {color:[0.3490196078f,0.09803921569f,0.7529411765f]}
assert data storage bs.color:rgb_to_hex {out:"#5919c0"}
