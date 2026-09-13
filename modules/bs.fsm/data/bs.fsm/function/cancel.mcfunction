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
# Macro: bind: "global" | "local"

# We use fsm instead of _ to avoid conflicts with lambdas, since we run the on_cancel command
$data modify storage bs:ctx fsm set value { machine: "$(name)", bind: "$(bind)" }

# Any other binding would silently fall through to the local branch
execute unless data storage bs:ctx fsm{bind: "global"} unless data storage bs:ctx fsm{bind: "local"} run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:cancel", \
  tag: "cancel", \
  message: [{text: "Invalid binding '"}, {nbt: "fsm.bind", storage: "bs:ctx"}, {text: "', expected 'global' or 'local'."}] \
}
execute unless data storage bs:ctx fsm{bind: "global"} unless data storage bs:ctx fsm{bind: "local"} run return fail

# We check if the machine is running, for a local machine @s is the entity it is bound to
scoreboard players set #s bs.ctx 0
$execute if data storage bs:ctx fsm{bind: "global"} store success score #s bs.ctx if data storage bs:data fsm.machines.'$(name)'
$execute unless data storage bs:ctx fsm{bind: "global"} store success score #s bs.ctx if data entity @s data.bs:fsm.machines.'$(name)'
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:cancel", \
  tag: "cancel", \
  message: [{text: "No machine named '"}, {nbt: "fsm.machine", storage: "bs:ctx"}, {text: "' is running in this context."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# Global machine
# We keep the on_cancel command aside, the machine is about to be dropped
$execute if data storage bs:ctx fsm{bind: "global"} run data modify storage bs:ctx fsm.command set from storage bs:data fsm.machines.'$(name)'.on_cancel
$execute if data storage bs:ctx fsm{bind: "global"} run function bs.fsm:run/stop_global { machine: "$(name)" }
# The on_cancel command runs once the machine is fully unregistered, so it may not read it back but may reuse its name
execute if data storage bs:ctx fsm{bind: "global"} if data storage bs:ctx fsm.command run function bs.fsm:run/run_command_global with storage bs:ctx fsm
execute if data storage bs:ctx fsm{bind: "global"} run return 1

# Local machine
# We get the String UUID of the entity, the tag is only needed to resolve the selector
tag @s add bs.fsm.entity
data modify entity B5-0-0-0-2 text set value { selector: "@n[tag=bs.fsm.entity]" }
data modify storage bs:ctx fsm.context set from entity B5-0-0-0-2 text.insertion
tag @s remove bs.fsm.entity

$data modify storage bs:ctx fsm.command set from entity @s data.bs:fsm.machines.'$(name)'.on_cancel
function bs.fsm:run/stop_local with storage bs:ctx fsm
execute if data storage bs:ctx fsm.command run function bs.fsm:run/run_command_local with storage bs:ctx fsm

return 1
