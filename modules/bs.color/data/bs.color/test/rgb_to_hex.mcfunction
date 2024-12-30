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

function #bs.color:rgb_to_hex {color:[242,106,59]}
assert data storage bs:out color{rgb_to_hex:"#f26a3b"}

function #bs.color:rgb_to_hex {color:[42,200,85]}
assert data storage bs:out color{rgb_to_hex:"#2ac855"}

function #bs.color:rgb_to_hex {color:[89,25,192]}
assert data storage bs:out color{rgb_to_hex:"#5919c0"}
