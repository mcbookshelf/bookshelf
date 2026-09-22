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
# - Macro machine: string

# We unregister the tick command and the listened transitions of the machine
$data remove storage bs:data fsm.ticks[{machine: "$(machine)", context: "global"}]
$data remove storage bs:data fsm.listened_transitions[{machine: "$(machine)", context: "global"}]

# We drop the machine itself, which frees its name
$data remove storage bs:data fsm.machines.'$(machine)'

return 1
