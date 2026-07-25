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

data modify storage bs:dump ctx.value set from storage bs:dump stack[-1].var
execute if data storage bs:dump ctx.value[] run return run function bs.dump:format/array/array
execute if data storage bs:dump ctx{value:[]} run return run function bs.dump:format/array/empty
execute if data storage bs:dump ctx.value{} run return run function bs.dump:format/compound/compound

execute store success score #dump.success bs.data run data modify storage bs:dump ctx.value set string storage bs:dump stack[-1].var
execute if score #dump.success bs.data matches 1 run return run function bs.dump:format/number with storage bs:const dump

loot replace entity B5-0-0-0-3 contents loot {pools:[{rolls:1,entries:[{type:"item",name:"egg",functions:[{function:"set_name",entity:"this",name:{storage:"bs:dump",nbt:"ctx.value"}}]}]}]}
data modify storage bs:dump ctx.value set from entity B5-0-0-0-3 item.components.minecraft:custom_name.extra
data modify storage bs:dump ctx.value[1].color set from storage bs:const dump.string
data modify storage bs:dump output append from storage bs:dump ctx.value
