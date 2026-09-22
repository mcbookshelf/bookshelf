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

data remove storage bs:ward fsm.cancel

# The initial state ticks and waits on a delay long enough to never elapse during the test
data modify storage bs:ward fsm.templates.cancel.ward_cancel set value { \
  initial: "a", \
  on_cancel: "data modify storage bs:ward fsm.cancel.trace append value cancelled", \
  states: [ \
    { \
      name: "a", \
      on_tick: "data modify storage bs:ward fsm.cancel.ticks append value 1", \
      transitions: [{ name: "never", condition: { type: "delay", wait: 1000 }, to: "b" }] \
    }, \
    { name: "b", final: true } \
  ] \
}

## === UNKNOWN MACHINE ===

# Cancelling a machine that is not running must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:cancel { name: "ward_unknown", bind: "global" }
assert score #ward.fsm bs.ctx matches 0

## === GLOBAL MACHINE ===

function #bs.fsm:init { name: "ward_cancel", uses: "bs:ward fsm.templates.cancel.ward_cancel" }
assert data storage bs:data fsm.ticks[{machine: "ward_cancel"}]
assert data storage bs:data fsm.listened_transitions[{machine: "ward_cancel"}]

# Cancelling drops the machine along with its tick command and its listened transitions
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:cancel { name: "ward_cancel", bind: "global" }
assert not score #ward.fsm bs.ctx matches 0
assert not data storage bs:data fsm.machines.ward_cancel
assert not data storage bs:data fsm.ticks[{machine: "ward_cancel"}]
assert not data storage bs:data fsm.listened_transitions[{machine: "ward_cancel"}]

# The on_cancel command of the template has been run in the global context
assert data storage bs:ward fsm.cancel{trace: ["cancelled"]}

## === FREED NAME ===

# Once cancelled, the name of the machine can be used again
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:init { name: "ward_cancel", uses: "bs:ward fsm.templates.cancel.ward_cancel" }
assert not score #ward.fsm bs.ctx matches 0
function #bs.fsm:cancel { name: "ward_cancel", bind: "global" }

## === LOCAL MACHINE ===

summon minecraft:marker ~ ~ ~ {Tags: ["bs.ward.fsm_cancel"]}
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_cancel,limit=1] at @s run function #bs.fsm:init_as { name: "ward_cancel", uses: "bs:ward fsm.templates.cancel.ward_cancel" }
assert data storage bs:data fsm.ticks[{machine: "ward_cancel"}]
assert data storage bs:data fsm.listened_transitions[{machine: "ward_cancel"}]

# Cancelling as the bound entity drops the machine stored on it
scoreboard players set #ward.fsm bs.ctx -1
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_cancel,limit=1] at @s store success score #ward.fsm bs.ctx run function #bs.fsm:cancel { name: "ward_cancel", bind: "local" }
assert not score #ward.fsm bs.ctx matches 0
assert not data entity @e[type=minecraft:marker,tag=bs.ward.fsm_cancel,limit=1] data.bs:fsm.machines.ward_cancel
assert not data storage bs:data fsm.ticks[{machine: "ward_cancel"}]
assert not data storage bs:data fsm.listened_transitions[{machine: "ward_cancel"}]

# The tag used to resolve the entity UUID must not be left behind
assert not entity @e[tag=bs.fsm.entity]

## === CLEANUP ===

kill @e[type=minecraft:marker,tag=bs.ward.fsm_cancel]
data remove storage bs:ward fsm.templates.cancel
