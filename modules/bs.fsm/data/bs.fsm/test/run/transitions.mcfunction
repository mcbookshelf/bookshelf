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

data remove storage bs:ward fsm.transitions

# A command transition is taken as soon as its command succeeds
data modify storage bs:ward fsm.templates.transitions.ward_command set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      transitions: [{ \
        name: "go", \
        condition: { type: "command", wait: "data get storage bs:ward fsm.transitions.gate" }, \
        to: "b" \
      }] \
    }, \
    { name: "b", final: true } \
  ] \
}

# A predicate transition is taken as soon as its predicate passes
data modify storage bs:ward fsm.templates.transitions.ward_predicate set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      transitions: [{ \
        name: "go", \
        condition: { type: "predicate", wait: "bs.fsm:test/always" }, \
        to: "b" \
      }] \
    }, \
    { name: "b", final: true } \
  ] \
}

## === COMMAND TRANSITION ===

function #bs.fsm:init { name: "ward_command", uses: "bs:ward fsm.templates.transitions.ward_command" }

# As long as the command fails, we stay in the current state
await delay 3t
assert data storage bs:data fsm.machines.ward_command.states[{name: "a", current: true}]

# Once the command succeeds, we move to the target state, which is final and thus stops the machine
data modify storage bs:ward fsm.transitions.gate set value 1
await not data storage bs:data fsm.machines.ward_command

## === PREDICATE TRANSITION ===

function #bs.fsm:init { name: "ward_predicate", uses: "bs:ward fsm.templates.transitions.ward_predicate" }
await not data storage bs:data fsm.machines.ward_predicate

## === CLEANUP ===

data remove storage bs:ward fsm.templates.transitions
