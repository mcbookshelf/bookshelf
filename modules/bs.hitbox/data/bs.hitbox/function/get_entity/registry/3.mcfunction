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

# armor_stand group
data modify storage bs:ctx _ set from entity @s
execute if data storage bs:ctx _{Marker:1b} run return run data modify storage bs:out hitbox set value {width:0.0,height:0.0}
execute if data storage bs:ctx _{Small:1b} run return run data modify storage bs:out hitbox set value {width:0.25,height:0.9875}
data modify storage bs:out hitbox set value {width:0.5,height:1.975}
