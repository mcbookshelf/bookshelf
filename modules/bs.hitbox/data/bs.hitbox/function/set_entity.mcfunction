# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

tag @s add bs.hitbox.custom
tag @s remove bs.hitbox.baked
tag @s remove bs.hitbox.centered

$data modify storage bs:ctx _ set value $(with)
execute if data storage bs:ctx _{centered:true} run tag @s add bs.hitbox.centered

execute unless data storage bs:ctx _.depth run data modify storage bs:ctx _.depth set from storage bs:ctx _.width
execute store result score @s bs.height run data get storage bs:ctx _.height 5000000
execute store result score @s bs.width run data get storage bs:ctx _.width 5000000
execute store result score @s bs.depth run data get storage bs:ctx _.depth 5000000
