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

# camel group
execute at @s positioned ~ ~1 ~ if entity @s[dx=0] run return run data modify storage bs:out hitbox set value {width:1.7,height:2.375}
execute unless predicate bs.hitbox:is_baby run return run data modify storage bs:out hitbox set value {width:1.7,height:0.945}
execute at @s positioned ~ ~1 ~ if entity @s[dx=0] run return run data modify storage bs:out hitbox set value {width:0.765,height:1.06875}
data modify storage bs:out hitbox set value {width:0.765,height:0.42525}
