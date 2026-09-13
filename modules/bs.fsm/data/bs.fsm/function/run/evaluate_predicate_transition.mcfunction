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

data modify storage bs:ctx _.transition set from storage bs:data fsm.listened_transitions[0]
data modify storage bs:ctx _.transition.predicate set from storage bs:ctx _.transition.condition.wait

# If this is a global predicate transition, we evaluate the predicate and according to the result, we switch to the target state
execute if data storage bs:data fsm.listened_transitions[0].global \
        store success score #s bs.ctx \
        run function bs.fsm:run/evaluate_global_predicate with storage bs:ctx _.transition

execute if score #s bs.ctx matches 1 run return run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if data storage bs:data fsm.listened_transitions[0].global run return fail

# If this is a local predicate transition, we evaluate the predicate and according to the result, we switch to the target state
execute store success score #s bs.ctx \
        run function bs.fsm:run/evaluate_local_predicate with storage bs:ctx _.transition

execute if score #s bs.ctx matches 1 run return run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]

return fail
