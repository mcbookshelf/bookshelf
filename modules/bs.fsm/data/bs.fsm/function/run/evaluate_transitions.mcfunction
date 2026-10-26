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
# - Storage bs:data fsm.listened_transitions: {source: <state_name>, context: <context>, command: <command>, machine: <machine>, to: <state_name>, condition: { type: "delay" | "predicate" | "function", wait: string }}[]

# Unlike the tick function, we will not use a counter to know when to stop the recursion
# Indeed, in the tick function we don't unregister the tick commands, so we cannot loose the count
# In this function, we will remove the transitions that have been evaluated, as well as all the transitions for this machine
# As we don't know how many transitions will be removed, we prefer to use a flag on transitions to directly know from the current transition if we need to continue the recursion

# Transitions registered by enter_state are flagged checked so they are skipped by the pass that registered them
# We clear the flags here so that everything registered since the last pass is evaluated by this one
data remove storage bs:data fsm.listened_transitions[].checked
function bs.fsm:run/evaluate_transitions_rec

# If we still have transitions to evaluate, we schedule again
execute if data storage bs:data fsm.listened_transitions[0] run schedule function bs.fsm:run/evaluate_transitions 1t
