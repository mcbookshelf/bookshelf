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
# Macro: uses: string

$data modify storage bs:ctx _ set value { uses: "$(uses)" }

# We work on a copy of the template, the checks annotate it as they go
$execute store success score #s bs.ctx run data modify storage bs:ctx _.template set from storage $(uses)
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "No FSM template found at '"}, {nbt: "_.uses", storage: "bs:ctx"}, {text: "'."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# The checks report through bs:out collection, which may hold a collection the caller is working on
# We keep it out of _, which the checks pass whole as a macro argument
data modify storage bs:ctx fsm_out set from storage bs:out collection

execute store success score #s bs.ctx run function bs.fsm:check/well_formedness
execute if score #s bs.ctx matches 1 run execute store success score #s bs.ctx run function bs.fsm:check/initiality
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/unicity
# Need to be call before reachability, since this latter uses the finals states
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/acceptability
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/reachability

# We give the caller its collection back, leaving nothing behind if it had none
data remove storage bs:out collection
data modify storage bs:out collection set from storage bs:ctx fsm_out

data remove storage bs:ctx fsm_out
data remove storage bs:ctx _

execute if score #s bs.ctx matches 0 run return fail

return 1
