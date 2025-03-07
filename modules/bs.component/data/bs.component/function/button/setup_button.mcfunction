# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Set properties
$data merge entity @s {width: $(width), height: $(height), Tags: ["bs.component.button"]}

# Setup the click event
$function #bs.interaction:on_right_click { run: "$(on_click)", executor: "source" }

# Setup hover events for glow effect
$function #bs.interaction:on_hover { run: "$(hover)", executor: { selector: "@e[tag=bs.component.icon, limit=1]", lazy: false }}
$function #bs.interaction:on_hover_leave { run: "$(hover_leave)", executor: { selector: "@e[tag=bs.component.icon, limit=1]", lazy: false }}
