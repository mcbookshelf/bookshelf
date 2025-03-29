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

# Test simple split
data modify storage bs:in string.split set value {str:"a,b,c,d",separator:",",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["a","b","c","d"]}

# Test with empty string
data modify storage bs:in string.split set value {str:"",separator:",",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:[""]}

# Test with empty separator
data modify storage bs:in string.split set value {str:"abc",separator:"",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["a","b","c"]}

# Test with consecutive separators
data modify storage bs:in string.split set value {str:"a,,b,,,c",separator:",",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["a","","b","","","c"]}

# Test with separator at start/end
data modify storage bs:in string.split set value {str:",start,middle,end,",separator:",",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["","start","middle","end",""]}

# Test with maxsplit
data modify storage bs:in string.split set value {str:"a:b:c:d:e",separator:":",maxsplit:2}
function #bs.string:split
assert data storage bs:out string{split:["a","b","c:d:e"]}

# Test with spaces
data modify storage bs:in string.split set value {str:"  spaces  between  words  ",separator:" ",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["","","spaces","","between","","words","",""]}

# Test with longer separator
data modify storage bs:in string.split set value {str:"word<->split<->by<->arrow",separator:"<->",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["word","split","by","arrow"]}

# Test with special characters
data modify storage bs:in string.split set value {str:"é★à★ê★ë",separator:"★",maxsplit:-1}
function #bs.string:split
assert data storage bs:out string{split:["é","à","ê","ë"]}
