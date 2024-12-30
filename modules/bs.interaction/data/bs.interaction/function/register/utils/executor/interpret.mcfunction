# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
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

$execute store result score #i bs.ctx run tag $(selector) add bs.interaction.this
data modify entity B5-0-0-0-2 text set value '{"selector":"@n[tag=bs.interaction.this]"}'
function bs.interaction:register/utils/executor/unquote with entity B5-0-0-0-2
data modify storage bs:ctx _.executor set from storage bs:ctx _.executor.insertion
tag @e[tag=bs.interaction.this] remove bs.interaction.this
