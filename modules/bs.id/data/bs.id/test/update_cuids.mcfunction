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

execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
kill @e[type=minecraft:armor_stand,distance=..1]

function #bs.id:update_cuids

assert entity @e[type=minecraft:marker,scores={bs.cid=1}] inside
assert entity @e[type=minecraft:marker,scores={bs.cid=2}] inside
assert entity @e[type=minecraft:marker,scores={bs.cid=3}] inside
assert entity @e[type=minecraft:marker,scores={bs.cid=4}] inside
kill @e[type=minecraft:marker,distance=..1]
