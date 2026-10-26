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

data remove storage bs:ward fsm.emit

# The initial state can only be left through a manual transition
data modify storage bs:ward fsm.templates.emit.ward_emit set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      on_enter: "data modify storage bs:ward fsm.emit.trace append value enter_a", \
      on_exit: "data modify storage bs:ward fsm.emit.trace append value exit_a", \
      transitions: [{ name: "go", condition: "manual", to: "b" }] \
    }, \
    { \
      name: "b", \
      on_enter: "data modify storage bs:ward fsm.emit.trace append value enter_b", \
      final: true \
    } \
  ] \
}

# The initial state mixes a manual transition with a delay long enough to never elapse during the test
data modify storage bs:ward fsm.templates.emit.ward_emit_mixed set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      transitions: [ \
        { name: "go", condition: "manual", to: "b" }, \
        { name: "timer", condition: { type: "delay", wait: 1000 }, to: "b" } \
      ] \
    }, \
    { name: "b", final: true } \
  ] \
}

## === UNKNOWN MACHINE ===

# Emitting to a machine that is not running must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_unknown", signal: "go", bind: "global" }
assert score #ward.fsm bs.ctx matches 0

## === GLOBAL MACHINE ===

function #bs.fsm:init { name: "ward_emit", uses: "bs:ward fsm.templates.emit.ward_emit" }
assert data storage bs:data fsm.machines.ward_emit.states[{name: "a", current: true}]
assert data storage bs:ward fsm.emit{trace: ["enter_a"]}

# A state whose only way out is manual listens to nothing, and does not end the machine either
assert not data storage bs:data fsm.listened_transitions[{machine: "ward_emit"}]

# A signal the current state does not listen to must fail and leave the machine where it is
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_emit", signal: "ward_unknown", bind: "global" }
assert score #ward.fsm bs.ctx matches 0
assert data storage bs:data fsm.machines.ward_emit.states[{name: "a", current: true}]

# The emitted signal takes the manual transition, so we reach the final state and the machine stops
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_emit", signal: "go", bind: "global" }
assert not score #ward.fsm bs.ctx matches 0
assert not data storage bs:data fsm.machines.ward_emit
assert data storage bs:ward fsm.emit{trace: ["enter_a", "exit_a", "enter_b"]}

## === NON MANUAL TRANSITION ===

function #bs.fsm:init { name: "ward_emit_mixed", uses: "bs:ward fsm.templates.emit.ward_emit_mixed" }
assert data storage bs:data fsm.listened_transitions[{machine: "ward_emit_mixed", name: "timer"}]

# Only manual transitions answer to a signal, even when a transition bears the emitted name
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_emit_mixed", signal: "timer", bind: "global" }
assert score #ward.fsm bs.ctx matches 0
assert data storage bs:data fsm.machines.ward_emit_mixed.states[{name: "a", current: true}]

# Taking the manual transition drops the delay transition still being listened to
function #bs.fsm:emit { name: "ward_emit_mixed", signal: "go", bind: "global" }
assert not data storage bs:data fsm.machines.ward_emit_mixed
assert not data storage bs:data fsm.listened_transitions[{machine: "ward_emit_mixed"}]

## === LOCAL MACHINE ===

data remove storage bs:ward fsm.emit
summon minecraft:marker ~ ~ ~ {Tags: ["bs.ward.fsm_emit"]}
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_emit,limit=1] at @s run function #bs.fsm:init_as { name: "ward_emit", uses: "bs:ward fsm.templates.emit.ward_emit" }
assert data entity @e[type=minecraft:marker,tag=bs.ward.fsm_emit,limit=1] data.bs:fsm.machines.ward_emit.states[{name: "a", current: true}]

# The machine runs on the entity, so emitting to a global machine of the same name must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_emit", signal: "go", bind: "global" }
assert score #ward.fsm bs.ctx matches 0

# Emitting as the bound entity takes the manual transition stored on it
scoreboard players set #ward.fsm bs.ctx -1
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_emit,limit=1] at @s store success score #ward.fsm bs.ctx run function #bs.fsm:emit { name: "ward_emit", signal: "go", bind: "local" }
assert not score #ward.fsm bs.ctx matches 0
assert not data entity @e[type=minecraft:marker,tag=bs.ward.fsm_emit,limit=1] data.bs:fsm.machines.ward_emit
assert data storage bs:ward fsm.emit{trace: ["enter_a", "exit_a", "enter_b"]}

# The tag used to resolve the entity UUID must not be left behind
assert not entity @e[tag=bs.fsm.entity]

## === CLEANUP ===

kill @e[type=minecraft:marker,tag=bs.ward.fsm_emit]
data remove storage bs:ward fsm.templates.emit
