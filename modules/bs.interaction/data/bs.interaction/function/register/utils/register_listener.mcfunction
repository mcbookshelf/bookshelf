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

# The registered event has the following properties:
# - id: The ID of the event.
# - type: The type of event.
# - run: The command to execute.
# - executor: The executor of the command.

# Get a new ID based on the ID of the last registered event incremented by 1.
$execute store result score #i bs.ctx run data get storage bs:data interaction.$(y)[0].id
execute store result storage bs:ctx _.id int 1 run scoreboard players add #i bs.ctx 1

$data modify storage bs:data interaction.$(y) prepend from storage bs:ctx _
return run scoreboard players get #i bs.ctx
