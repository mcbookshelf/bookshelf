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

# Test empty string
data modify storage bs:in string.reverse.str set value ""
function #bs.string:reverse
assert data storage bs:out string{reverse:""}

# Test single character
data modify storage bs:in string.reverse.str set value "a"
function #bs.string:reverse
assert data storage bs:out string{reverse:"a"}

# Test normal string
data modify storage bs:in string.reverse.str set value "Hello World"
function #bs.string:reverse
assert data storage bs:out string{reverse:"dlroW olleH"}

# Test string with special characters
data modify storage bs:in string.reverse.str set value "!@#$%^"
function #bs.string:reverse
assert data storage bs:out string{reverse:"^%$#@!"}

# Test string with numbers
data modify storage bs:in string.reverse.str set value "12345"
function #bs.string:reverse
assert data storage bs:out string{reverse:"54321"}
