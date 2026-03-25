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

# goat group
execute at @s positioned ~ ~1 ~ if entity @s[dx=0] run return run data modify storage bs:out hitbox set value {width:0.9,height:1.3}
execute unless predicate bs.hitbox:internal/is_baby run return run data modify storage bs:out hitbox set value {width:0.63,height:0.91}
execute at @s positioned ~ ~.6 ~ if entity @s[dx=0] run return run data modify storage bs:out hitbox set value {width:0.495,height:0.715}
data modify storage bs:out hitbox set value {width:0.3465,height:0.5005}
