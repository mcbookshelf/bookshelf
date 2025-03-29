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

# Test simple replacement
data modify storage bs:in string.replace set value {str:"hello world", old:"world", new:"minecraft", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"hello minecraft"}

# Test empty string
data modify storage bs:in string.replace set value {str:"", old:"test", new:"replace", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:""}

# Test empty new string
data modify storage bs:in string.replace set value {str:"remove this", old:"this", new:"", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"remove "}

# Test multiple replacements
data modify storage bs:in string.replace set value {str:"a a a a", old:"a", new:"b", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"b b b b"}

# Test case sensitivity
data modify storage bs:in string.replace set value {str:"Test test TEST", old:"test", new:"replaced", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"Test replaced TEST"}

# Test with sspecial characters
data modify storage bs:in string.replace set value {str:"éàêë", old:"ê", new:"e", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"éàeë"}

# Test with longer string
data modify storage bs:in string.replace set value {str:"short", old:"short", new:"very long replacement", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"very long replacement"}

# Test with shorter string
data modify storage bs:in string.replace set value {str:"very long original", old:"very long", new:"short", maxreplace:-1}
function #bs.string:replace
assert data storage bs:out string{replace:"short original"}

# Test with maxreplace limit
data modify storage bs:in string.replace set value {str:"replace replace replace replace", old:"replace", new:"changed", maxreplace:2}
function #bs.string:replace
assert data storage bs:out string{replace:"changed changed replace replace"}

# Test with maxreplace=1
data modify storage bs:in string.replace set value {str:"test test test", old:"test", new:"done", maxreplace:1}
function #bs.string:replace
assert data storage bs:out string{replace:"done test test"}
