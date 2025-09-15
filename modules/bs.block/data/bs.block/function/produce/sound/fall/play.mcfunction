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

data modify storage bs:ctx _ set value {source:"master",targets:"@s",pos:"~ ~ ~",volume:1,pitch:1,min_volume:0}
data modify storage bs:ctx _ merge from storage bs:in block.play_fall_sound

execute if data storage bs:ctx _.type run function bs.block:produce/sound/fall/lookup with storage bs:ctx _
execute unless data storage bs:ctx _.type run function bs.block:produce/sound/fall/get
function bs.block:produce/sound/run with storage bs:ctx _
