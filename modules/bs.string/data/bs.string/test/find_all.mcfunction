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

# Test simple case
data modify storage bs:in string.find_all set value {str:"hello world",substr:"world",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[6]}

# Test empty string
data modify storage bs:in string.find_all set value {str:"",substr:"test",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[]}

# Test empty substr
data modify storage bs:in string.find_all set value {str:"test string",substr:"",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[]}

# Test multiple occurrences
data modify storage bs:in string.find_all set value {str:"test test test",substr:"test",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[0,5,10]}

# Test with occurrence limit
data modify storage bs:in string.find_all set value {str:"find find find find",substr:"find",occurrence:2}
function #bs.string:find_all
assert data storage bs:out string{find_all:[0,5]}

# Test with special characters
data modify storage bs:in string.find_all set value {str:"éàêëàéêë",substr:"êë",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[2,6]}

# Test case sensitivity
data modify storage bs:in string.find_all set value {str:"Test TEST test",substr:"test",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[10]}

# Test overlapping patterns
data modify storage bs:in string.find_all set value {str:"aaaaa",substr:"aa",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[0,1,2,3]}

# Test substr not found
data modify storage bs:in string.find_all set value {str:"hello world",substr:"notfound",occurrence:-1}
function #bs.string:find_all
assert data storage bs:out string{find_all:[]}
