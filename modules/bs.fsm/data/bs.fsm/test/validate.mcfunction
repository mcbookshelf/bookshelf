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

data remove storage bs:ward fsm.templates.validate

## === UNKNOWN TEMPLATE ===

# Validating a path holding no template must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.ward_unknown" }
assert score #ward.fsm bs.ctx matches 0

## === VALID TEMPLATE ===

data modify storage bs:ward fsm.templates.validate.valid set value { \
  initial: "idle", \
  on_cancel: "bs.fsm:test/cancel", \
  states: [ \
    { \
      name: "idle", \
      on_tick: "bs.fsm:test/tick", \
      on_enter: "bs.fsm:test/enter", \
      on_exit: "bs.fsm:test/exit", \
      transitions: [{ name: "start", condition: "manual", to: "active" }] \
    }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.valid" }
assert not score #ward.fsm bs.ctx matches 0


## === MINIMAL TEMPLATE ===

data modify storage bs:ward fsm.templates.validate.minimal set value { \
  initial: "state1", \
  states: [{ name: "state1", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.minimal" }
assert not score #ward.fsm bs.ctx matches 0

## === NAMES THAT ARE NOT IDENTIFIERS ===

# Names are plain strings: numbers, booleans and spaces must survive the checks like the runtime accepts them
data modify storage bs:ward fsm.templates.validate.names set value {   initial: "1",   states: [     { name: "1", transitions: [{ name: "go", condition: "manual", to: "true" }] },     { name: "true", transitions: [{ name: "go", condition: "manual", to: "Patrol Area" }] },     { name: "Patrol Area", final: true }   ] }
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.names" }
assert not score #ward.fsm bs.ctx matches 0

## === TEMPLATE WITH EVERY TRANSITION TYPE ===

data modify storage bs:ward fsm.templates.validate.complex set value { \
  initial: "start", \
  states: [ \
    { \
      name: "start", \
      transitions: [ \
        { name: "manual_transition", condition: "manual", to: "waiting" }, \
        { name: "predicate_transition", condition: { type: "predicate", wait: "bs.fsm:test/always" }, to: "processing" }, \
        { name: "command_transition", condition: { type: "command", wait: "bs.fsm:test/function" }, to: "processing" }, \
        { name: "delay_transition", condition: { type: "delay", wait: 20 }, to: "processing" } \
      ] \
    }, \
    { \
      name: "waiting", \
      transitions: [{ name: "manual_transition", condition: "manual", to: "processing" }] \
    }, \
    { name: "processing", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.complex" }
assert not score #ward.fsm bs.ctx matches 0

## === NO INITIAL STATE ===

data modify storage bs:ward fsm.templates.validate.no_initial set value { \
  states: [{ name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.no_initial" }
assert score #ward.fsm bs.ctx matches 0

## === UNKNOWN INITIAL STATE ===

data modify storage bs:ward fsm.templates.validate.bad_initial set value { \
  initial: "nonexistent", \
  states: [{ name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.bad_initial" }
assert score #ward.fsm bs.ctx matches 0

## === DUPLICATE STATE NAMES ===

data modify storage bs:ward fsm.templates.validate.duplicate set value { \
  initial: "idle", \
  states: [{ name: "idle", final: true }, { name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.duplicate" }
assert score #ward.fsm bs.ctx matches 0

## === TRANSITION TO AN UNKNOWN STATE ===

data modify storage bs:ward fsm.templates.validate.bad_transition set value { \
  initial: "idle", \
  states: [ \
    { \
      name: "idle", \
      transitions: [ \
        { name: "bad", condition: "manual", to: "nonexistent" }, \
        { name: "start", condition: "manual", to: "active" } \
      ] \
    }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.bad_transition" }
assert score #ward.fsm bs.ctx matches 0

## === UNREACHABLE FINAL STATE ===

data modify storage bs:ward fsm.templates.validate.unreachable set value { \
  initial: "idle", \
  states: [{ name: "idle", final: false }, { name: "final_state", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.unreachable" }
assert score #ward.fsm bs.ctx matches 0

## === NO FINAL STATE ===

data modify storage bs:ward fsm.templates.validate.no_final set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [{ name: "start", condition: "manual", to: "active" }] }, \
    { name: "active", final: false } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.no_final" }
assert score #ward.fsm bs.ctx matches 0

## === UNNAMED MANUAL TRANSITION ===

data modify storage bs:ward fsm.templates.validate.unnamed_manual set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [{ condition: "manual", to: "active" }] }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.unnamed_manual" }
assert score #ward.fsm bs.ctx matches 0

## === UNKNOWN CONDITION TYPE ===

data modify storage bs:ward fsm.templates.validate.bad_condition set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [{ name: "go", condition: { type: "unknown", wait: "bs.fsm:test/unknown" }, to: "active" }] }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.bad_condition" }
assert score #ward.fsm bs.ctx matches 0

## === RESERVED NAMES ===

# No state name is reserved, in particular the tags carried by the shared Bookshelf markers
data modify storage bs:ward fsm.templates.validate.reserved set value { \
  initial: "bs.entity", \
  states: [ \
    { name: "bs.entity", transitions: [{ name: "start", condition: "manual", to: "smithed.entity" }] }, \
    { name: "smithed.entity", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.reserved" }
assert not score #ward.fsm bs.ctx matches 0

# A transition targeting such a name without a matching state must still fail
data modify storage bs:ward fsm.templates.validate.reserved_unknown set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [ \
      { name: "start", condition: "manual", to: "active" }, \
      { name: "bad", condition: "manual", to: "bs.persistent" } \
    ] }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.reserved_unknown" }
assert score #ward.fsm bs.ctx matches 0

## === TRANSITION WITHOUT TARGET ===

data modify storage bs:ward fsm.templates.validate.no_target set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [{ name: "go", condition: "manual" }] }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.no_target" }
assert score #ward.fsm bs.ctx matches 0

## === CALLER COLLECTION ===

# The checks report through bs:out collection, which must be given back to the caller untouched
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.minimal" }
assert data storage bs:out collection{value: [1, 2, 3]}

# A caller working on no collection must not be left with one
data remove storage bs:out collection
function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.minimal" }
assert not data storage bs:out collection

## === CLEANUP ===

data remove storage bs:ward fsm.templates.validate
