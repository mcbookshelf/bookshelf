# 🔄 Finite State Machine

**`#bs.fsm:help`**

A powerful Finite State Machine (FSM) system for managing complex state-based behaviors in Minecraft.

```{epigraph}
FSMs are without a doubt the most commonly used technology in game AI programming today. 
They are conceptually simple, efficient, easily extensible, and yet powerful enough to handle a wide variety of situations.

-- Daniel D. Fu & Ryan Houlette
```

The FSM module provides a comprehensive system for creating, managing, and executing finite state machines. 
It allows you to define states, transitions, and behaviors in a declarative way, making complex state management simple and maintainable.

---

## 📦 Templates

A state machine is described by a **template**: a plain NBT compound that you store wherever you want, with vanilla commands.
Since a template is just data, you can write it once on load, or build and edit it at runtime, and you choose how to namespace it.

:::{treeview}
- {nbt}`compound` Template
  - {nbt}`string` **initial**: Name of the initial state (must exist in states array).
  - {nbt}`string` **on_cancel**: Command to run when the machine is cancelled (optional).
  - {nbt}`list` **states**: Array of state definitions.
    - {nbt}`compound` State
      - {nbt}`string` **name**: Unique name for the state.
      - {nbt}`string` **on_tick**: Command to run every tick while in this state (optional).
      - {nbt}`string` **on_enter**: Command to run when entering this state (optional).
      - {nbt}`string` **on_exit**: Command to run when exiting this state (optional).
      - {nbt}`bool` **final**: Whether this state is a final state (optional, default: false). Validation metadata only, never read at runtime: a machine stops as soon as it enters a state with no outgoing transition, whether or not it is flagged. Validation requires a final state to have no transition, so on a validated template the two coincide.
      - {nbt}`list` **transitions**: Array of transition definitions (optional).
        - {nbt}`compound` Transition
          - {nbt}`string` **name**: Name of the transition (optional, required on a manual transition: it is the signal name that fires it).
          - {nbt}`string` {nbt}`compound` **condition**: Transition condition. One of the following:
            - {nbt}`string` Manual transition: the literal `"manual"`, triggered by the `#bs.fsm:emit` feature.
            - {nbt}`compound` Predicate-based transition.
              - {nbt}`string` **type**: Must be "predicate".
              - {nbt}`string` **wait**: Predicate to check to trigger the transition.
            - {nbt}`compound` Command-based transition.
              - {nbt}`string` **type**: Must be "command".
              - {nbt}`string` **wait**: Command to check to trigger the transition.
            - {nbt}`compound` Time-based transition.
              - {nbt}`string` **type**: Must be "delay".
              - {nbt}`int` **wait**: Number of ticks after entering the state before the transition fires (0 acts as 1).
          - {nbt}`string` **to**: Name of the target state (must exist in states array).
:::

*Example: store a light template, then validate it:*

```mcfunction
# Store the template wherever you want
data modify storage my_pack:fsm light set value { \
  initial: "off", \
  states: [ \
    { \
      name: "off", \
      on_enter: "setblock ~ ~ ~ minecraft:redstone_lamp", \
      transitions: [{ name: "turn_on", condition: "manual", to: "on" }] \
    }, \
    { \
      name: "on", \
      on_enter: "setblock ~ ~ ~ minecraft:redstone_lamp[lit=true]", \
      final: true \
    } \
  ] \
}

# Check it once, before running it
function #bs.fsm:validate { uses: "my_pack:fsm light" }
```

Since the template is yours, you delete it like any other data:

```mcfunction
data remove storage my_pack:fsm light
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Validate

```{function} #bs.fsm:validate

Check that a template describes a valid state machine, and report every problem found through the log module.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **uses**: Storage source of the template, as `<namespace>:<storage> <path>`.
  :::

:Outputs:
  **Return**: Success (1) if the template is valid, failure (0) otherwise.
```

*Example: validate a template:*

```mcfunction
function #bs.fsm:validate { uses: "my_pack:fsm light" }
```

Running machines are never validated: this is up to you.
Validate a static template once on load, and a dynamic one every time you are done editing it.

> **Credits**: theogiraudet

---

### Init

:::::{tab-set}
::::{tab-item} Global Machine

```{function} #bs.fsm:init

Run a new state machine from a template, in the global context.
The global context doesn't keep the context (`as`, `at`, …) in which it is executed.
Therefore, such a context should directly be specified in different callback commands.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Unique name of the machine, used to address it later.
    - {nbt}`string` **uses**: Storage source of the template, as `<namespace>:<storage> <path>`.
  :::

:Outputs:
  **Return**: Success (1) if the machine was started, failure (0) otherwise.

  **State**: The machine runs globally, starting in its initial state.
```

*Example: run a light machine:*

```mcfunction
function #bs.fsm:init { name: "main_light", uses: "my_pack:fsm light" }

# The light machine is now running globally and has entered its initial state
```

> **Credits**: theogiraudet

::::
::::{tab-item} Local Machine

```{function} #bs.fsm:init_as

Run new state machines from a template, bound to the executing entities.
The commands and predicates of the machine are executed as and at the entity it is bound to.
If the entity leaves the world while the machine runs, whether it is killed or its chunk is unloaded, the module automatically stops its tick commands and transitions evaluation.
The machine itself stays stored on the entity, so an entity coming back does not resume it and still holds its name: cancel it as that entity to free the name again.

:Inputs:
  **Execution `as <entities>`**: Entities to bind. The entities must not be players.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Unique name of the machine for this entity, used to address it later.
    - {nbt}`string` **uses**: Storage source of the template, as `<namespace>:<storage> <path>`.
  :::

:Outputs:
  **Return**: Success (1) if the machine was started, failure (0) otherwise.

  **State**: The machines run on the executing entities, starting in their initial state.
```

*Example: run a light machine bound to an entity:*

```mcfunction
execute as @n[type=zombie] run function #bs.fsm:init_as { name: "entity_light", uses: "my_pack:fsm light" }

# The light machine is now running on this zombie and has entered its initial state
```

> **Credits**: theogiraudet

::::
:::::

---

### Emit

```{function} #bs.fsm:emit

Emit a signal to a running machine.
The signal takes the manual transition of the current state bearing that name, if there is one.

:Inputs:
  **Execution `as <entity>`**: Entity the machine is bound to, for a local machine.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Name of the machine to emit the signal to.
    - {nbt}`string` **signal**: Name of the signal to emit.
    - {nbt}`string` **bind**: Binding of the machine.
      - **"global"**: The machine runs in the global context.
      - **"local"**: The machine runs on the current execution context.
  :::

:Outputs:
  **Return**: Success (1) if the signal triggered a transition, failure (0) otherwise.

  **State**: The machine moves to the target state of the transition, running the `on_exit` of the current state then the `on_enter` of the new one.
```

*Example: emit a signal to a machine:*

```mcfunction
# Emit a signal to a global machine
function #bs.fsm:emit { name: "main_light", signal: "turn_on", bind: "global" }

# Emit a signal to a machine bound to an entity
execute as @n[type=zombie] run function #bs.fsm:emit { name: "entity_light", signal: "turn_on", bind: "local" }
```

Emitting a signal the current state does not listen to is not an error: the machine simply stays where it is and the function fails.
Only a machine that is not running at all is reported through the log module.

> **Credits**: theogiraudet

---

### Cancel

```{function} #bs.fsm:cancel

Cancel and stop a running machine.

:Inputs:
  **Execution `as <entity>`**: Entity the machine is bound to, for a local machine.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Name of the machine to cancel.
    - {nbt}`string` **bind**: Binding of the machine.
      - **"global"**: The machine runs in the global context.
      - **"local"**: The machine runs on the current execution context.
  :::

:Outputs:
  **Return**: Success (1) if the machine was cancelled successfully, failure (0) otherwise.

  **State**: The machine is stopped and cleaned up: it stops ticking, stops listening to transitions, and its name becomes available again. If its template has an on_cancel command, it is run.
```

*Example: cancel a door machine:*

```mcfunction
# Cancel the door machine
function #bs.fsm:cancel { name: "main_door", bind: "global" }

# The door machine is now stopped
```

The `on_cancel` command runs once the machine has been unregistered, so it cannot read the machine back, but it may start a new one under the same name.
Cancelling does not run the `on_exit` command of the current state.

> **Credits**: theogiraudet

---

## ❓ What is a FSM?

A Finite State Machine (FSM) is a conceptual model used to describe how a system behaves in response to events. 
It defines a limited set of possible states that the system can be in at any given moment. 
The system starts in an initial state and, when something happens, such as receiving an input or a signal, it may change its state following predefined rules. 
These changes are called transitions, and each one depends on the current state and the event received.

What makes FSMs powerful is their simplicity and clarity. 
By reducing a system's behavior to a set of states and transitions, we can describe even complex logic in a very structured and predictable way. 
At any point in time, the system is in exactly one state, and the logic for moving between states is well defined. 
This helps avoid ambiguity and makes it easier to understand how the system reacts to different situations.

In Minecraft, Finite State Machines can be particularly useful to manage tree dialog, boss phases, or any system state.
Outside Minecraft, Finite State Machines are widely used in many fields because they provide a clean way to manage systems that have different modes or stages. 
In software development, they are useful for designing user interfaces, game character behavior, communication protocols, and more. 
In hardware and control systems, they are often used to manage sequences of operations or reactions to sensor inputs. 
Overall, FSMs are a fundamental tool for modeling reactive systems in a way that is both rigorous and easy to reason about.

## 💡 Example in Minecraft

```{mermaid}
stateDiagram-v2
    [*] --> Idle

    Idle --> Alert : if player detected

    Alert --> Attack : after 5s AND player still detected
    Alert --> Idle : after 5s AND player gone

    Attack --> Searching : if player lost

    Searching --> Attack : if player found
    Searching --> Idle : after 10s AND player not found

    Attack --> Idle : if player defeated
```

This finite state machine controls the behavior of a custom mob in Minecraft: a sentinel that guards a specific area. 
It begins in the **Idle** state, where it stays mostly still, occasionally performing small ambient animations. 
When a player enters its detection radius, as determined by a custom command or predicate, the FSM transitions to the **Alert** state.
In the **Alert** state, the sentinel visually or audibly signals that it has detected an intruder. 
This state is time-based, lasting about five seconds. 
If the player is still present when this period ends, the sentinel moves to the **Attack** state.
During **Attack**, the mob actively pursues and attacks the player. 
If the player escapes or is no longer detectable, the FSM transitions to the **Searching** state. 
There, the sentinel wanders the area near the last known location of the intruder for a set amount of time.
If it finds the player again during this search, it returns to **Attack**. 
Otherwise, if the timer runs out without detecting anyone, it returns to the **Idle** state and resumes its guard duty.
If the player is defeated, the FSM transitions to the **Idle** state and resumes its guard duty.



---
## 📋 Validation Rules

The FSM system enforces several validation rules to ensure proper operation:

### Initiality
- The FSM must have an `initial` state specified
- The initial state must exist in the states array

### Unicity
- All state names must be unique within the FSM

### Acceptability
- The FSM must have at least one final state
- Final states are states marked with `final: true`

### Reachability
- Every state must be able to reach a final state
- This is determined by walking the transition graph backwards from the final states

### Transition Validation
- All transition target states must exist in the states array
- Transition conditions must be valid according to their type
- Manual transitions must have a name, since that name is the signal firing them

---

## 🔄 State Lifecycle

Each state in an FSM follows a specific lifecycle:

1. **Enter**: The `on_enter` function is called when entering the state
2. **Tick**: The `on_tick` function is called every tick while in the state
3. **Transition evaluation**: When a transition condition is met, the state transitions
   Transitions are evaluated once per tick, starting the tick after the state was entered, so a machine never chains several automatic transitions within a single tick
4. **Exit**: The `on_exit` function is called when leaving the state

A machine ends when it enters a state with no outgoing transition, which is what a final state is.
Its `on_enter` still runs, then the machine is unregistered: it stops ticking, stops listening to transitions, and its name becomes available again.
A machine that has not reached such a state runs until you stop it with `#bs.fsm:cancel`.

---

## ⚡ Transition Types

The FSM system supports several types of transitions:

### Manual
Triggered by `#bs.fsm:emit`, which fires the manual transition of the current state named after the emitted signal.
Useful for player interactions or external events.

### Predicate
Triggered when a predicate returns true. 
Useful for conditional logic.

### Command
Triggered when a command succeeds. 
Useful for complex conditions.

### Delay
Triggered `wait` ticks after entering the state, whichever way it was entered. 
Useful for timed behaviors.

---

## ⚠️ Best Practices

1. **Keep states focused**: Each state should represent a single, well-defined behavior
2. **Use meaningful names**: State and transition names should clearly describe their purpose
3. **Handle edge cases**: Always consider what happens when transitions fail
4. **Clean up resources**: Use the on_exit functions to clean up state-specific resources
5. **Define a cancel command**: Use a `on_cancel` command to clean up resources when the FSM is cancelled
