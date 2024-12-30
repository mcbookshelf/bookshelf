# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

data modify storage bs:data log.messages set value []
$data modify storage bs:data log.messages append from storage bs:data log.history[$(with)].message
execute if data storage bs:data log.messages[0] run tellraw @s {"storage": "bs:data", "nbt": "log.messages[]", "separator": "\n", "interpret": true}
execute unless data storage bs:data log.messages[0] run tellraw @s {"text": "No log entries to show…","color":"gray"}
