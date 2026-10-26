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

# Input:
# Storage: bs:ctx _.template (a FSM)

# Goal: check if the names of the states are unique
# How do we proceed?
# We deduplicate the list of the states names and compare its size with the number of states
# If they are different, that means that there are duplicate names

execute store result score #a bs.ctx run data get storage bs:ctx _.template.states

data modify storage bs:out collection.value set value []
data modify storage bs:out collection.value append from storage bs:ctx _.template.states[].name

# bs.collection works in bs:ctx _, so we move our context aside during the call
# We use check and not fsm, which the runtime holds while it runs the commands of a machine
data modify storage bs:ctx check set from storage bs:ctx _
function #bs.collection:distinct
data modify storage bs:ctx _ set from storage bs:ctx check
data remove storage bs:ctx check

execute store result score #b bs.ctx run data get storage bs:out collection.value

# If the deduplicated list is shorter than the list of states, that means that there are duplicate names so we log an error and return
execute unless score #a bs.ctx = #b bs.ctx run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:check/unicity", \
  tag: "unicity", \
  message: [{text: "The names of the states are not unique."}] \
}
execute unless score #a bs.ctx = #b bs.ctx run return fail

# Else, we return success
return 1
