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

#one char
data modify storage bs:in string.replace.str set value "a sentance all more normal "
data modify storage bs:in string.replace.old set value " "
data modify storage bs:in string.replace.new set value "_"

function #bs.string:replace
assert data storage bs:out {string:{replace:"a_sentance_all_more_normal_"}}


data modify storage bs:in string.replace.str set value "a sentance all more normal "
data modify storage bs:in string.replace.old set value "all more"
data modify storage bs:in string.replace.new set value "no more"

function #bs.string:replace
assert data storage bs:out {string:{replace:"a sentance no more normal "}}

data modify storage bs:in string.replace.str set value "a secret message"
data modify storage bs:in string.replace.old set value "e"
data modify storage bs:in string.replace.new set value "#"

function #bs.string:replace
assert data storage bs:out {string:{replace:"a s#cr#t m#ssag#"}}
