# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Test basic find
data modify storage bs:in string.find.str set value "hello world"
data modify storage bs:in string.find.needle set value "world"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[6]}}

# Test empty string
data modify storage bs:in string.find.str set value ""
data modify storage bs:in string.find.needle set value "test"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[]}}

# Test empty needle
data modify storage bs:in string.find.str set value "test string"
data modify storage bs:in string.find.needle set value ""
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[]}}

# Test multiple occurrences
data modify storage bs:in string.find.str set value "test test test"
data modify storage bs:in string.find.needle set value "test"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[0,5,10]}}

# Test with occurrence limit
data modify storage bs:in string.find.str set value "find find find find"
data modify storage bs:in string.find.needle set value "find"
function #bs.string:find {occurrence:2}
assert data storage bs:out {string:{find:[0,5]}}

# Test with Unicode
data modify storage bs:in string.find.str set value "éàêëàéêë"
data modify storage bs:in string.find.needle set value "êë"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[2,6]}}

# Test case sensitivity
data modify storage bs:in string.find.str set value "Test TEST test"
data modify storage bs:in string.find.needle set value "test"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[10]}}

# Test overlapping patterns
data modify storage bs:in string.find.str set value "aaaaa"
data modify storage bs:in string.find.needle set value "aa"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[0,1,2,3]}}

# Test needle not found
data modify storage bs:in string.find.str set value "hello world"
data modify storage bs:in string.find.needle set value "notfound"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[]}}
