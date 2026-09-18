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

data remove storage bs:ward fsm.delay

# Two machines wait 3 ticks in b before reaching c: one starts in b, the other reaches b from a through an
# automatic transition. Each state stamps the tick it is entered so we can check the exact timings
data modify storage bs:ward fsm.templates.delay.direct set value { \
  initial: "b", \
  states: [ \
    { \
      name: "b", \
      on_enter: "execute store result storage bs:ward fsm.delay.direct.b int 1 run time query gametime", \
      transitions: [{ name: "go", condition: { type: "delay", wait: 3 }, to: "c" }] \
    }, \
    { name: "c", on_enter: "execute store result storage bs:ward fsm.delay.direct.c int 1 run time query gametime", final: true } \
  ] \
}
data modify storage bs:ward fsm.templates.delay.chained set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      on_enter: "execute store result storage bs:ward fsm.delay.chained.a int 1 run time query gametime", \
      transitions: [{ name: "go", condition: { type: "predicate", wait: "bs.fsm:test/always" }, to: "b" }] \
    }, \
    { \
      name: "b", \
      on_enter: "execute store result storage bs:ward fsm.delay.chained.b int 1 run time query gametime", \
      transitions: [{ name: "go", condition: { type: "delay", wait: 3 }, to: "c" }] \
    }, \
    { name: "c", on_enter: "execute store result storage bs:ward fsm.delay.chained.c int 1 run time query gametime", final: true } \
  ] \
}

## === CHAINING ===

function #bs.fsm:init { name: "ward_delay_direct", uses: "bs:ward fsm.templates.delay.direct" }
function #bs.fsm:init { name: "ward_delay_chained", uses: "bs:ward fsm.templates.delay.chained" }

await data storage bs:ward fsm.delay.direct.c
await data storage bs:ward fsm.delay.chained.c

# The automatic transition fires the tick after a is entered, never within the same tick
execute store result score #ward.fsm bs.ctx run data get storage bs:ward fsm.delay.chained.b
execute store result score #ward.fsm.a bs.ctx run data get storage bs:ward fsm.delay.chained.a
scoreboard players operation #ward.fsm bs.ctx -= #ward.fsm.a bs.ctx
assert score #ward.fsm bs.ctx matches 1

## === DELAY ===

# wait: 3 fires exactly 3 ticks after entering b, whichever way b was entered
execute store result score #ward.fsm bs.ctx run data get storage bs:ward fsm.delay.direct.c
execute store result score #ward.fsm.b bs.ctx run data get storage bs:ward fsm.delay.direct.b
scoreboard players operation #ward.fsm bs.ctx -= #ward.fsm.b bs.ctx
assert score #ward.fsm bs.ctx matches 3

execute store result score #ward.fsm bs.ctx run data get storage bs:ward fsm.delay.chained.c
execute store result score #ward.fsm.b bs.ctx run data get storage bs:ward fsm.delay.chained.b
scoreboard players operation #ward.fsm bs.ctx -= #ward.fsm.b bs.ctx
assert score #ward.fsm bs.ctx matches 3

## === CLEANUP ===

data remove storage bs:ward fsm.templates.delay
data remove storage bs:ward fsm.delay
