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
# Macro: $(current_state) (a state name)
# Storage: bs:ctx _.template (a FSM)

# Output:
# Storage: bs:ctx _.source_states (a list of states name)

data modify storage bs:ctx _.source_states set value []
$data modify storage bs:ctx _.source_states append from storage bs:ctx _.template.states[{transitions: [{to: "$(current_state)"}]}]
