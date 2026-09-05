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

summon marker ~ ~ ~ {Tags:["bs.ward.animation.create.baked"]}
data modify storage bs:ward animation.create.baked_one set value { run: "<callback>", _: ["<baked>"] }
execute as @n[tag=bs.ward.animation.create.baked] run function #bs.animation:create {id:"one",uses:"bs:ward animation.create.baked_one"}
assert data entity @n[tag=bs.ward.animation.create.baked] data{"bs.animation":[{id:"one",run:"<callback>",_:["<baked>"]}]}

data modify storage bs:ward animation.create.baked_many set value [{ run: "<callback1>", _: ["<baked1>"] },{ run: "<callback2>", _: ["<baked2>"] }]
execute as @n[tag=bs.ward.animation.create.baked] run function #bs.animation:create {id:"many",uses:"bs:ward animation.create.baked_many"}
assert data entity @n[tag=bs.ward.animation.create.baked] data{"bs.animation":[{id:"many",run:"<callback1>",_:["<baked1>"]},{id:"many",run:"<callback2>",_:["<baked2>"]}]}
kill @n[tag=bs.ward.animation.create.baked]
