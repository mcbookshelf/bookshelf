# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
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

#Setup fast storage
data modify storage bs:in string.lower.str set value "HELLO WORLD"
data modify storage bs:in string.upper.str set value "hello world"
function #bs.string:lower {type:"fast"}
function #bs.string:upper {type:"fast"}

#Test
assert data storage bs:out {string:{lower:"hello world"}}
assert data storage bs:out {string:{upper:"HELLO WORLD"}}

#Setup Slow storage
data modify storage bs:in string.lower.str set value "HELLO WORLD"
data modify storage bs:in string.upper.str set value "hello world"
function #bs.string:lower {type:"slow"}
function #bs.string:upper {type:"slow"}

#Test
assert data storage bs:out {string:{lower:"hello world"}}
assert data storage bs:out {string:{upper:"HELLO WORLD"}}
