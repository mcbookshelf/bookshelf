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

data modify storage bs:out hitbox set value {scale:1.0}
execute store result storage bs:out hitbox.width double .0000002 run scoreboard players get @s bs.width
execute store result storage bs:out hitbox.depth double .0000002 run scoreboard players get @s bs.depth
execute store result storage bs:out hitbox.height double .0000001 run scoreboard players get @s bs.height
