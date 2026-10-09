# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

data remove storage ward.schedule:append out

# The command runs once the delay has passed
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:append out.ticks set value 1b",time:3,id:"ward.schedule.append"}
execute unless function #bs.schedule:schedule/append run fail "a scheduled command is a failure"
await delay 2t
assert not data storage ward.schedule:append out.ticks
await data storage ward.schedule:append out.ticks

# The delay can be a time string
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:append out.seconds set value 1b",time:"1s",id:"ward.schedule.append"}
function #bs.schedule:schedule/append
await delay 19t
assert not data storage ward.schedule:append out.seconds
await data storage ward.schedule:append out.seconds

# Commands with the same id on the same tick all run
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:append out.stack append value 1b",time:1,id:"ward.schedule.append"}
function #bs.schedule:schedule/append
function #bs.schedule:schedule/append
await data storage ward.schedule:append out.stack[1]

# A delay of zero is refused
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:append out.now set value 1b",time:0,id:"ward.schedule.append"}
execute if function #bs.schedule:schedule/append run fail "a delay of zero is a success"
await delay 2t
assert not data storage ward.schedule:append out.now

# The command can be given as arguments
function #bs.schedule:schedule/append.in {id:"ward.schedule.append.in",run:"data modify storage ward.schedule:append out.in set value 1b",time:1}
await data storage ward.schedule:append out.in
