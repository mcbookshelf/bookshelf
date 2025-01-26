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

# bad size
data modify storage bs:in string.find.str set value "mot"
data modify storage bs:in string.find.needle set value "motus"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[]}}

# unique reference
data modify storage bs:in string.find.str set value "motmott"
data modify storage bs:in string.find.needle set value "t"
function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[2,5,6]}}

#normal one
data modify storage bs:in string.find.str set value "mot cacher est un mot trés en motte"
data modify storage bs:in string.find.needle set value "mot"

function #bs.string:find {occurrence:0}
assert data storage bs:out {string:{find:[0, 18, 30]}}

#count test
function #bs.string:find {occurrence:2}
assert data storage bs:out {string:{find:[0, 18]}}

#reversed test 
#function #bs.string:find {occurrence:-2}
#assert data storage bs:out {string:{find:[18, 30]}}
