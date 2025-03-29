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

# The registered event has the following properties:
# - id: The ID of the event.
# - type: The type of event.
# - run: The command to execute.
# - executor: The executor of the command.

# Get a new event ID based on the ID of the last registered event incremented by 1.
execute store result score #i bs.ctx run data get entity @s data."bs.interaction".events[0].id
execute store result storage bs:ctx _.id int 1 run scoreboard players add #i bs.ctx 1
data modify entity @s data."bs.interaction".events prepend from storage bs:ctx _

execute if entity @s[tag=bs.interaction.is_hoverable] \
  unless score @s bs.interaction.hover matches ..2147483647 \
  store result score @s bs.interaction.hover \
  run scoreboard players add #counter bs.interaction.hover 1

return run scoreboard players get #i bs.ctx
