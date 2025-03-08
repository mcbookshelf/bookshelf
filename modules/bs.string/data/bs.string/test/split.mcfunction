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

# Test basic split
data modify storage bs:in string.split.str set value "a,b,c,d"
data modify storage bs:in string.split.separator set value ","
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["a","b","c","d"]}}

# Test with empty string
data modify storage bs:in string.split.str set value ""
data modify storage bs:in string.split.separator set value ","
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:[""]}}

# Test with empty separator (to hard to implement use to_list insted)
data modify storage bs:in string.split.str set value "abc"
data modify storage bs:in string.split.separator set value ""
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["a","b","c"]}}

# Test with multiple consecutive separators
data modify storage bs:in string.split.str set value "a,,b,,,c"
data modify storage bs:in string.split.separator set value ","
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["a","","b","","","c"]}}

# Test with separator at start/end
data modify storage bs:in string.split.str set value ",start,middle,end,"
data modify storage bs:in string.split.separator set value ","
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["","start","middle","end",""]}}

# Test with maxsplit
data modify storage bs:in string.split.str set value "a:b:c:d:e"
data modify storage bs:in string.split.separator set value ":"
function #bs.string:split {maxsplit:2}
assert data storage bs:out {string:{split:["a","b","c:d:e"]}}

# Test with spaces
data modify storage bs:in string.split.str set value "  spaces  between  words  "
data modify storage bs:in string.split.separator set value " "
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["","","spaces","","between","","words","",""]}}

# Test with longer separator
data modify storage bs:in string.split.str set value "word<->split<->by<->arrow"
data modify storage bs:in string.split.separator set value "<->"
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["word","split","by","arrow"]}}

# Test with Unicode
data modify storage bs:in string.split.str set value "é★à★ê★ë"
data modify storage bs:in string.split.separator set value "★"
function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["é","à","ê","ë"]}}
