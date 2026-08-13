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

$data modify storage bs:ctx @.i set from storage $(uses)
execute if data storage bs:ctx @.i[0] run function bs.animation:create/many
execute if data storage bs:ctx @.i{} run function bs.animation:create/one
$data modify storage bs:ctx @.o[].id set value "$(id)"
data modify entity @s data."bs.animation" append from storage bs:ctx @.o[]
data remove storage bs:ctx @
