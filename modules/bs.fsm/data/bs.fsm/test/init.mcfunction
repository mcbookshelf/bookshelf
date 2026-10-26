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

## === SETUP ===

data remove storage bs:ward fsm.init

data modify storage bs:ward fsm.templates.init.ward_init set value { \
  initial: "idle", \
  states: [ \
    { \
      name: "idle", \
      on_enter: "data modify storage bs:ward fsm.init append value entered_idle", \
      transitions: [{ name: "go", condition: "manual", to: "done" }] \
    }, \
    { name: "done", final: true } \
  ] \
}

## === UNKNOWN TEMPLATE ===

# Running a machine from a path holding no template must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:init { name: "ward_init", uses: "bs:ward fsm.templates.init.ward_unknown" }
assert score #ward.fsm bs.ctx matches 0
assert not data storage bs:data fsm.machines.ward_init

## === GLOBAL MACHINE ===

# Running a machine registers it and enters the initial state
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:init { name: "ward_init", uses: "bs:ward fsm.templates.init.ward_init" }
assert not score #ward.fsm bs.ctx matches 0
assert data storage bs:data fsm.machines.ward_init
assert data storage bs:data fsm.machines.ward_init.states[{name: "idle", current: true}]
assert not data storage bs:data fsm.machines.ward_init.states[{name: "done", current: true}]

# The on_enter command of the initial state has been run in the global context
assert data storage bs:ward fsm{init: ["entered_idle"]}

## === DUPLICATE NAME ===

# Running a second machine under an already used name must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:init { name: "ward_init", uses: "bs:ward fsm.templates.init.ward_init" }
assert score #ward.fsm bs.ctx matches 0
# The initial state must not have been entered a second time
assert data storage bs:ward fsm{init: ["entered_idle"]}

## === CLEANUP ===

data remove storage bs:data fsm.listened_transitions[{machine: "ward_init"}]
data remove storage bs:data fsm.ticks[{machine: "ward_init"}]
data remove storage bs:data fsm.machines.ward_init
data remove storage bs:ward fsm.templates.init
