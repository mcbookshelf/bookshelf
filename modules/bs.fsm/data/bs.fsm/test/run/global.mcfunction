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

data remove storage bs:ward fsm.global

# A two-states machine: the first one is left after a 6 ticks delay
data modify storage bs:ward fsm.templates.global.ward_global set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      on_enter: "data modify storage bs:ward fsm.global.trace append value enter_a", \
      on_tick: "data modify storage bs:ward fsm.global.ticks append value 1", \
      on_exit: "data modify storage bs:ward fsm.global.trace append value exit_a", \
      transitions: [{ name: "go", condition: { type: "delay", wait: 6 }, to: "b" }] \
    }, \
    { \
      name: "b", \
      on_enter: "data modify storage bs:ward fsm.global.trace append value enter_b", \
      final: true \
    } \
  ] \
}

## === ENTER ===

# The on_enter command of the initial state runs synchronously
function #bs.fsm:init { name: "ward_global", uses: "bs:ward fsm.templates.global.ward_global" }
assert data storage bs:ward fsm.global{trace: ["enter_a"]}
assert data storage bs:data fsm.ticks[{machine: "ward_global"}]

## === TICK ===

# The on_tick command of the current state runs on every tick
await data storage bs:ward fsm.global.ticks[1]

## === DELAY TRANSITION AND EXIT ===

# Once the delay has elapsed, we exit the current state and enter the target one
await data storage bs:ward fsm.global{trace: ["enter_a", "exit_a", "enter_b"]}

## === AUTOMATIC STOP ===

# The target state has no outgoing transition, so the machine is dropped as soon as it is entered
assert not data storage bs:data fsm.machines.ward_global

# The state we left must not tick nor listen to its transitions anymore
assert not data storage bs:data fsm.ticks[{machine: "ward_global"}]
assert not data storage bs:data fsm.listened_transitions[{machine: "ward_global"}]

## === CLEANUP ===

data remove storage bs:ward fsm.templates.global
