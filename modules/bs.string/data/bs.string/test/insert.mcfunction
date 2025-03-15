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

# Test basic insert
data modify storage bs:in string.insert.str set value "Hello World"
data modify storage bs:in string.insert.substr set value "Beautiful "
function #bs.string:insert {index:6}
assert data storage bs:out {string:{insert:"Hello Beautiful World"}}

# Test insert at start
data modify storage bs:in string.insert.str set value "World"
data modify storage bs:in string.insert.substr set value "Hello "
function #bs.string:insert {index:0}
assert data storage bs:out {string:{insert:"Hello World"}}

# Test insert at end
data modify storage bs:in string.insert.str set value "Hello"
data modify storage bs:in string.insert.substr set value " World"
function #bs.string:insert {index:5}
assert data storage bs:out {string:{insert:"Hello World"}}

# Test insert into empty string
data modify storage bs:in string.insert.str set value ""
data modify storage bs:in string.insert.substr set value "test"
function #bs.string:insert {index:0}
assert data storage bs:out {string:{insert:"test"}}

# Test insert empty string
data modify storage bs:in string.insert.str set value "test"
data modify storage bs:in string.insert.substr set value ""
function #bs.string:insert {index:2}
assert data storage bs:out {string:{insert:"test"}}

# Test with Unicode
data modify storage bs:in string.insert.str set value "éë"
data modify storage bs:in string.insert.substr set value "à"
function #bs.string:insert {index:1}
assert data storage bs:out {string:{insert:"éàë"}}

# Test with negative index
data modify storage bs:in string.insert.str set value "test"
data modify storage bs:in string.insert.substr set value "pre "
function #bs.string:insert {index:-4}
assert data storage bs:out {string:{insert:"pre test"}}
