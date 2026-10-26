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

# Goal: check if the specified initial state exist in the FSM
execute store success score #s bs.ctx run function bs.fsm:check/internal/initiality with storage bs:ctx _.template
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "The initial state does not exist in the FSM."}] \
}
execute if score #s bs.ctx matches 0 run return fail

return 1
