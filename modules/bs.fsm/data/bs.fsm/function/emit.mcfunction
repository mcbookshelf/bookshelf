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
# Macro: signal: string
# Macro: bind: "global" | "local"

# We use fsm instead of _ to avoid conflicts with lambdas, since switch_state runs the commands of the machine
$data modify storage bs:ctx fsm set value { machine: "$(name)", bind: "$(bind)", context: "global" }

# Any other binding would silently fall through to the local branch
execute unless data storage bs:ctx fsm{bind: "global"} unless data storage bs:ctx fsm{bind: "local"} run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:emit", \
  tag: "emit", \
  message: [{text: "Invalid binding '"}, {nbt: "fsm.bind", storage: "bs:ctx"}, {text: "', expected 'global' or 'local'."}] \
}
execute unless data storage bs:ctx fsm{bind: "global"} unless data storage bs:ctx fsm{bind: "local"} run return fail

# We check if the machine is running, for a local machine @s is the entity it is bound to
scoreboard players set #s bs.ctx 0
$execute if data storage bs:ctx fsm{bind: "global"} store success score #s bs.ctx if data storage bs:data fsm.machines.'$(name)'
$execute unless data storage bs:ctx fsm{bind: "global"} store success score #s bs.ctx if data entity @s data.bs:fsm.machines.'$(name)'
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:emit", \
  tag: "emit", \
  message: [{text: "No machine named '"}, {nbt: "fsm.machine", storage: "bs:ctx"}, {text: "' is running in this context."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# For a local machine, we get the String UUID of the entity, the tag is only needed to resolve the selector
execute unless data storage bs:ctx fsm{bind: "global"} run tag @s add bs.fsm.entity
execute unless data storage bs:ctx fsm{bind: "global"} run data modify entity B5-0-0-0-2 text set value { selector: "@n[tag=bs.fsm.entity]" }
execute unless data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.context set from entity B5-0-0-0-2 text.insertion
execute unless data storage bs:ctx fsm{bind: "global"} run tag @s remove bs.fsm.entity

# We look for a manual transition of the current state named after the emitted signal
# Global machine
$execute if data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.source set from storage bs:data fsm.machines.'$(name)'.states[{current: true}].name
$execute if data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.to set from storage bs:data fsm.machines.'$(name)'.states[{current: true}].transitions[{name: "$(signal)", condition: "manual"}].to
# Local machine
$execute unless data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.source set from entity @s data.bs:fsm.machines.'$(name)'.states[{current: true}].name
$execute unless data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.to set from entity @s data.bs:fsm.machines.'$(name)'.states[{current: true}].transitions[{name: "$(signal)", condition: "manual"}].to

# The current state may simply not listen to this signal, which is not an error
execute unless data storage bs:ctx fsm.to run return fail

# switch_state overwrites bs:ctx fsm, so nothing may be read back from it afterwards
function bs.fsm:run/switch_state with storage bs:ctx fsm
return 1
