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

# Input:
# Macro: name: string
# Macro: uses: string

$data modify storage bs:ctx _ set value { machine: "$(name)", uses: "$(uses)" }

# Players cannot hold custom entity data, so a machine cannot be bound to them
execute if entity @s[type=player] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:init_as", \
  tag: "init_as", \
  message: [{text: "A machine cannot be bound to a player."}] \
}
execute if entity @s[type=player] run return fail

# We get the String UUID of the entity, the tag is only needed to resolve the selector
tag @s add bs.fsm.entity
data modify entity B5-0-0-0-2 text set value { selector: "@n[tag=bs.fsm.entity]" }
data modify storage bs:ctx _.context set from entity B5-0-0-0-2 text.insertion
tag @s remove bs.fsm.entity

# We check if a machine with this name is already running on this entity
$execute if data entity @s data.bs:fsm.machines.'$(name)' run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:init_as", \
  tag: "init_as", \
  message: [{text: "A machine named '"}, {nbt: "_.machine", storage: "bs:ctx"}, {text: "' is already running on entity '"}, {nbt: "_.context", storage: "bs:ctx"}, {text: "'."}] \
}
$execute if data entity @s data.bs:fsm.machines.'$(name)' run return fail

# We copy the template on the entity, which fails if the template does not exist
$execute store success score #s bs.ctx run data modify entity @s data.bs:fsm.machines.'$(name)' set from storage $(uses)
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:init_as", \
  tag: "init_as", \
  message: [{text: "No FSM template found at '"}, {nbt: "_.uses", storage: "bs:ctx"}, {text: "'."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# We enter the initial state
$data modify storage bs:ctx _.state_name set from entity @s data.bs:fsm.machines.'$(name)'.initial
function bs.fsm:run/enter_state_local with storage bs:ctx _
