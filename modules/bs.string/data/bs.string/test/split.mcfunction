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

#normal
data modify storage bs:in string.split.str set value "a sentance all more normal"
data modify storage bs:in string.split.separator set value " "

function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["a","sentance","all","more","normal"]}}
execute store result score #t bs.ctx run data get storage bs:out string.split
assert score #t bs.ctx matches 5


data modify storage bs:in string.split.str set value "a sentance all more normal "
data modify storage bs:in string.split.separator set value " "

function #bs.string:split {maxsplit:0}
assert data storage bs:out {string:{split:["a","sentance","all","more","normal",""]}}
execute store result score #t bs.ctx run data get storage bs:out string.split
assert score #t bs.ctx matches 6


#count
function #bs.string:split {maxsplit:2}
assert data storage bs:out {string:{split:["a","sentance","all more normal "]}}

function #bs.string:split {maxsplit:20}
assert data storage bs:out {string:{split:["a","sentance","all", "more", "normal",""]}}
execute store result score #t bs.ctx run data get storage bs:out string.split
assert score #t bs.ctx matches 6
