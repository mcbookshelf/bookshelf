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

# camel group
execute store success score #s bs.ctx if predicate bs.hitbox:internal/is_baby
execute if score #s bs.ctx matches 0 run data modify storage bs:out hitbox set value {width:1.7,height:2.375}
execute if score #s bs.ctx matches 0 if function bs.hitbox:get_entity/pose/is_sitting run data modify storage bs:out hitbox set value {width:1.7,height:0.945}
execute if score #s bs.ctx matches 1 run data modify storage bs:out hitbox set value {width:0.95,height:1.4}
execute if score #s bs.ctx matches 1 if function bs.hitbox:get_entity/pose/is_sitting run data modify storage bs:out hitbox set value {width:0.95,height:0.425}
