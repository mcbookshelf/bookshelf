# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Test to_list
data modify storage bs:in string.to_list.str set value "le mot"
function #bs.string:to_list
assert data storage bs:out string{to_list:["l","e"," ","m","o","t"]}

# Test to_string
data modify storage bs:in string.to_string.val set value 42
function #bs.string:to_string
assert data storage bs:out string{to_string:"42"}

# Test parse
data modify storage bs:in string.parse.str set value "42"
function #bs.string:parse
assert data storage bs:out string{parse:42}
