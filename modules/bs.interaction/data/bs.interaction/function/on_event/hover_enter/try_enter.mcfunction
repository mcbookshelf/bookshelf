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

$execute if predicate {condition:entity_properties,entity:this,predicate:{type_specific:{type:player,looking_at:{type:interaction,nbt:"{Tags:[bs.interaction.is_hoverable]}",distance:{absolute:{max:$(y)}}}}}} run function bs.interaction:on_event/hover_enter/hover_enter
