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

data remove storage bs:ward fsm.switch

# A global machine: its first state is left on demand, the next one ticks and lingers
data modify storage bs:ward fsm.templates.switch.ward_switch_global set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      transitions: [{ name: "go", condition: { type: "command", wait: "execute if data storage bs:ward fsm.switch{fire: true}" }, to: "b" }] \
    }, \
    { \
      name: "b", \
      on_enter: "data modify storage bs:ward fsm.switch.trace append value enter_b", \
      on_tick: "data modify storage bs:ward fsm.switch.ticks append value 1", \
      transitions: [{ name: "never", condition: { type: "delay", wait: 1000 }, to: "c" }] \
    }, \
    { name: "c", final: true } \
  ] \
}

# Local machines whose only transition can never fire on their own
data modify storage bs:ward fsm.templates.switch.ward_switch_local set value { \
  initial: "x", \
  states: [ \
    { name: "x", transitions: [{ name: "never", condition: { type: "command", wait: "return fail" }, to: "y" }] }, \
    { name: "y", on_enter: "data modify storage bs:ward fsm.switch.trace append value phantom", final: true } \
  ] \
}

# The global transition is listened first, followed by two local ones
function #bs.fsm:init { name: "ward_switch", uses: "bs:ward fsm.templates.switch.ward_switch_global" }
summon minecraft:marker ~ ~ ~ {Tags: ["bs.ward.fsm_switch"]}
summon minecraft:marker ~ ~ ~ {Tags: ["bs.ward.fsm_switch"]}
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_switch] at @s run function #bs.fsm:init_as { name: "ward_switch", uses: "bs:ward fsm.templates.switch.ward_switch_local" }

## === A SWITCH ONLY AFFECTS ITS OWN MACHINE ===

# Once the global machine has switched, the local ones listened right after it must be untouched:
# their transition must not be re-evaluated with the global state's on_tick command
data modify storage bs:ward fsm.switch.fire set value true
await data storage bs:ward fsm.switch{trace: ["enter_b"]}
assert not data storage bs:ward fsm.switch{trace: ["phantom"]}
assert data storage bs:data fsm.listened_transitions[{machine: "ward_switch", context: "global"}]

## === CLEANUP ===

function #bs.fsm:cancel { name: "ward_switch", bind: "global" }
kill @e[type=minecraft:marker,tag=bs.ward.fsm_switch]
data remove storage bs:ward fsm.templates.switch
data remove storage bs:ward fsm.switch
