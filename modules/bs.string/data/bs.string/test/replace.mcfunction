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

# Test basic replacement
data modify storage bs:in string.replace.str set value "hello world"
data modify storage bs:in string.replace.old set value "world"
data modify storage bs:in string.replace.new set value "minecraft"
function #bs.string:replace
assert data storage bs:out {string:{replace:"hello minecraft"}}

# Test empty string
data modify storage bs:in string.replace.str set value ""
data modify storage bs:in string.replace.old set value "test"
data modify storage bs:in string.replace.new set value "replace"
function #bs.string:replace
assert data storage bs:out {string:{replace:""}}

# Test empty old string
data modify storage bs:in string.replace.str set value "test string"
data modify storage bs:in string.replace.old set value ""
data modify storage bs:in string.replace.new set value "X"
function #bs.string:replace
assert data storage bs:out {string:{replace:"test string"}}

# Test empty new string
data modify storage bs:in string.replace.str set value "remove this"
data modify storage bs:in string.replace.old set value "this"
data modify storage bs:in string.replace.new set value ""
function #bs.string:replace
assert data storage bs:out {string:{replace:"remove "}}

# Test multiple replacements
data modify storage bs:in string.replace.str set value "a a a a"
data modify storage bs:in string.replace.old set value "a"
data modify storage bs:in string.replace.new set value "b"
function #bs.string:replace
assert data storage bs:out {string:{replace:"b b b b"}}

# Test case sensitivity
data modify storage bs:in string.replace.str set value "Test test TEST"
data modify storage bs:in string.replace.old set value "test"
data modify storage bs:in string.replace.new set value "replaced"
function #bs.string:replace
assert data storage bs:out {string:{replace:"Test replaced TEST"}}

# Test with Unicode
data modify storage bs:in string.replace.str set value "éàêë"
data modify storage bs:in string.replace.old set value "ê"
data modify storage bs:in string.replace.new set value "e"
function #bs.string:replace
assert data storage bs:out {string:{replace:"éàeë"}}

# Test replacing with longer string
data modify storage bs:in string.replace.str set value "short"
data modify storage bs:in string.replace.old set value "short"
data modify storage bs:in string.replace.new set value "very long replacement"
function #bs.string:replace
assert data storage bs:out {string:{replace:"very long replacement"}}

# Test replacing with shorter string
data modify storage bs:in string.replace.str set value "very long original"
data modify storage bs:in string.replace.old set value "very long"
data modify storage bs:in string.replace.new set value "short"
function #bs.string:replace
assert data storage bs:out {string:{replace:"short original"}}
