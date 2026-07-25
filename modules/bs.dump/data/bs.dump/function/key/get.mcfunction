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

loot replace entity B5-0-0-0-3 contents loot {pools:[{rolls:1,entries:[{type:"item",name:"egg",functions:[{function:"set_name",entity:"this",name:{storage:"bs:dump",nbt:"stack[-1].var"}}]}]}]}
data modify storage bs:dump stack[-1].qkey set value ""
data modify storage bs:dump stack[-1].key set from entity B5-0-0-0-3 item.components.minecraft:custom_name.extra
execute unless data storage bs:dump stack[-1].key[2].extra run return run data modify storage bs:dump stack[-1].key set from storage bs:dump stack[-1].key[2].text
data modify storage bs:dump stack[-1].qkey set from storage bs:dump stack[-1].key[2].text
data modify storage bs:dump stack[-1].key set from storage bs:dump stack[-1].key[2].extra[0].text
