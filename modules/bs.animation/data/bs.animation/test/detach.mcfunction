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

summon marker ~ ~ ~ {Tags:["ward.animation.detach"],data:{"bs.animation":[{id:"foo"},{id:"bar"},{id:"foo"}]}}
data modify storage bs.animation:detach in set value {id:"missing"}
assert not run execute as @n[tag=ward.animation.detach] run function #bs.animation:detach
data modify storage bs.animation:detach in set value {id:"foo"}
assert run execute as @n[tag=ward.animation.detach] run function #bs.animation:detach
assert not data entity @n[tag=ward.animation.detach] data."bs.animation"[{id:"foo"}]
assert data entity @n[tag=ward.animation.detach] data."bs.animation"[{id:"bar"}]
assert result 1 run data get entity @n[tag=ward.animation.detach] data."bs.animation"
kill @n[tag=ward.animation.detach]
