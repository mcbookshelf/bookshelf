# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Clear any existing FSM data
data remove storage bs:data fsm.fsm

## === VALID FSM CREATION ===

# Test 1: Create a simple valid FSM
function #bs.fsm:new { \
  name: "test_fsm", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        transitions: [ \
          { \
            name: "start", \
            condition: "manual", \
            to: "active" \
          } \
        ] \
      }, \
      { \
        name: "active", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: true \
      } \
    ] \
  } \
}
execute unless data storage bs:data fsm.fsm.test_fsm run fail "Failed to create a valid FSM"

## === DUPLICATE FSM ERROR ===

# Test 2: Try to create the same FSM again (should fail)
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "test_fsm", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit" \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when creating a duplicate FSM"

## === INVALID FSM - MISSING INITIAL STATE ===

# Test 3: Create FSM with missing initial state
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_1", \
  fsm: { \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit" \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when FSM has no initial state"

## === INVALID FSM - INITIAL STATE NOT FOUND ===

# Test 4: Create FSM with initial state that doesn't exist
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_2", \
  fsm: { \
    initial: "nonexistent", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit" \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when initial state doesn't exist"

## === INVALID FSM - DUPLICATE STATE NAMES ===

# Test 5: Create FSM with duplicate state names
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_3", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit" \
      }, \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit" \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when FSM has duplicate state names"

## === INVALID FSM - TRANSITION TO NONEXISTENT STATE ===

# Test 6: Create FSM with transition to non-existent state
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_4", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        transitions: [ \
          { \
            name: "start", \
            condition: "manual", \
            to: "nonexistent" \
          }, \
          { \
            name: "start", \
            condition: "manual", \
            to: "active" \
          } \
        ] \
      }, \
      { \
        name: "active", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: true \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when transition points to non-existent state"

## === VALID FSM WITH COMPLEX TRANSITIONS ===

# Test 7: Create a valid FSM with different transition types
function #bs.fsm:new { \
  name: "complex_fsm", \
  fsm: { \
    initial: "start", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "start", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        transitions: [ \
          { \
            name: "manual_transition", \
            condition: "manual", \
            to: "waiting" \
          }, \
          { \
            name: "predicate_transition", \
            condition: { type: "predicate", wait: "bs.fsm:test/condition" }, \
            to: "processing" \
          }, \
          { \
            name: "function_transition", \
            condition: { type: "command", wait: "bs.fsm:test/function" }, \
            to: "processing" \
          }, \
          { \
            name: "hook_transition", \
            condition: { type: "hook", wait: "bs.fsm:test/hook" }, \
            to: "processing" \
          }, \
          { \
            name: "delay_transition", \
            condition: { type: "delay", wait: "20t" }, \
            to: "processing" \
          } \
        ] \
      }, \
      { \
        name: "waiting", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        transitions: [ \
          { \
            name: "manual_transition", \
            condition: "manual", \
            to: "processing" \
          } \
        ] \
      }, \
      { \
        name: "processing", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: true \
      } \
    ] \
  } \
}
execute unless data storage bs:data fsm.fsm.complex_fsm run fail "Failed to create a complex FSM with various transition types"

## === VALID FSM WITH MINIMAL CONFIGURATION ===

# Test 8: Create a minimal valid FSM
function #bs.fsm:new { \
  name: "minimal_fsm", \
  fsm: { \
    initial: "state1", \
    states: [ \
      { \
        name: "state1", \
        final: true \
      } \
    ] \
  } \
}
execute unless data storage bs:data fsm.fsm.minimal_fsm run fail "Failed to create a minimal FSM"

## === INVALID FSM - UNREACHABLE FINAL STATE ===

# Test 9: Create FSM with unreachable final state
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_5", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: false \
      }, \
      { \
        name: "final_state", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: true \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when FSM has unreachable final state"

## === INVALID FSM - NO FINAL STATE ===

# Test 10: Create FSM with no final state
execute store success score #s bs.ctx run function #bs.fsm:new { \
  name: "invalid_fsm_6", \
  fsm: { \
    initial: "idle", \
    on_cancel: "bs.fsm:test/cancel", \
    states: [ \
      { \
        name: "idle", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: false \
      }, \
      { \
        name: "active", \
        on_tick: "bs.fsm:test/tick", \
        on_enter: "bs.fsm:test/enter", \
        on_exit: "bs.fsm:test/exit", \
        final: false \
      } \
    ] \
  } \
}
execute unless score #s bs.ctx matches 0 run fail "Failed to return an error when FSM has no final state"

## === CLEANUP ===

# Clean up test data
data remove storage bs:data fsm.fsm
