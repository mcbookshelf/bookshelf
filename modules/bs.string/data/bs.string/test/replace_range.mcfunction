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

# Test simple replace_range
data modify storage bs:in string.replace_range set value {str:"Hello World",substr:" Beautiful ",start:5,end:6}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:"Hello Beautiful World"}

# Test replace_range at start
data modify storage bs:in string.replace_range set value {str:"World",substr:"Hello ",start:0,end:0}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:"Hello World"}

# Test replace_range at end
data modify storage bs:in string.replace_range set value {str:"Hello",substr:" World",start:5,end:5}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:"Hello World"}

# Test replace_range into empty string
data modify storage bs:in string.replace_range set value {str:"",substr:"test",start:0,end:0}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:"test"}

# Test replace_range empty string
data modify storage bs:in string.replace_range set value {str:"test",substr:"",start:0,end:4}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:""}

# Test with special characters
data modify storage bs:in string.replace_range set value {str:"éàêë",substr:"à",start:1,end:4}
function #bs.string:replace_range {index:1}
assert data storage bs:out string{replace_range:"éà"}

# Test with negative index
data modify storage bs:in string.replace_range set value {str:"test",substr:"good che",start:-4,end:-2}
function #bs.string:replace_range
assert data storage bs:out string{replace_range:"good chest"}
