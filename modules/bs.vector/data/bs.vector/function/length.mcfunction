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

execute store result storage bs:data vector.distance[0] float 1 run scoreboard players get $vector.length.0 bs.in
execute store result storage bs:data vector.distance[4] float 1 run scoreboard players get $vector.length.1 bs.in
execute store result storage bs:data vector.distance[8] float 1 run scoreboard players get $vector.length.2 bs.in
data modify entity B5-0-0-0-2 transformation set from storage bs:data vector.distance

execute store result score $vector.length bs.out run return run data get entity B5-0-0-0-2 transformation.scale[0]
