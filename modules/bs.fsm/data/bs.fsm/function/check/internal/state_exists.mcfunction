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
# Macro: searched (a state name)
# Storage: bs:ctx check.template (a FSM)

# Output:
# Return 0 or 1 (0 if no state has this name, 1 if one does)

# Names are user strings: quote them, or a name like 1 or true is parsed as a number and never matches
$return run execute if data storage bs:ctx check.template.states[{name: "$(searched)"}]
