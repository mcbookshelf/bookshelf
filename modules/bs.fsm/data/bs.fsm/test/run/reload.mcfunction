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
# The load below holds the shared loops for a second, which would break the timings of the other tests:
# an environment of its own runs this test in a separate batch
# @environment bs.load:fsm/reload

## === SETUP ===

data remove storage bs:ward fsm.reload

# The initial state ticks and waits on a delay long enough to never elapse during the test
data modify storage bs:ward fsm.templates.reload.ward_reload set value { \
  initial: "a", \
  states: [ \
    { \
      name: "a", \
      on_tick: "data modify storage bs:ward fsm.reload.ticks append value 1", \
      transitions: [{ name: "never", condition: { type: "delay", wait: 1000 }, to: "b" }] \
    }, \
    { name: "b", final: true } \
  ] \
}

## === LOOPS RESUME AFTER A LOAD ===

function #bs.fsm:init { name: "ward_reload", uses: "bs:ward fsm.templates.reload.ward_reload" }
await data storage bs:ward fsm.reload.ticks[0]

# A world load starts over with no schedule pending, and the machines still registered
schedule clear bs.fsm:run/tick
schedule clear bs.fsm:run/evaluate_transitions
data remove storage bs:ward fsm.reload.ticks

# The load function arms the loops back, so the machine keeps running instead of freezing
function bs.fsm:__load__
await data storage bs:ward fsm.reload.ticks[0]
assert data storage bs:data fsm.listened_transitions[{machine: "ward_reload"}]

## === CLEANUP ===

function #bs.fsm:cancel { name: "ward_reload", bind: "global" }
data remove storage bs:ward fsm.templates.reload
data remove storage bs:ward fsm.reload
