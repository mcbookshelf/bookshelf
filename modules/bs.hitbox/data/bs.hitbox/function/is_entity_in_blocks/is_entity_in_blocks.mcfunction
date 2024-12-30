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

execute if entity @s[type=#bs.hitbox:intangible] run return 0

function #bs.hitbox:get_entity
execute if entity @s[type=#bs.hitbox:is_shaped] run function bs.hitbox:is_entity_in_blocks/shaped
execute unless entity @s[type=#bs.hitbox:is_shaped] run function bs.hitbox:is_entity_in_blocks/sized

data modify storage bs:ctx _ set value {ignored_blocks:"#bs.hitbox:intangible"}
$data modify storage bs:ctx _ merge value $(with)
return run function bs.hitbox:is_entity_in_blocks/recurse/init with storage bs:ctx
