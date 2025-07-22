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

## 🔧 Functions

You can find below all functions available in this module.

---

### New

```{function} #bs.fsm:new

Create a new Finite State Machine (FSM) with the specified configuration.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Unique identifier for the FSM.
    - {nbt}`compound` **fsm**: FSM configuration object.
      - {nbt}`string` **initial**: Name of the initial state (must exist in states array).
      - {nbt}`string` **on_cancel**: Function to call when the FSM is cancelled (optional).
      - {nbt}`list` **states**: Array of state definitions.
        - {nbt}`compound` State
          - {nbt}`string` **name**: Unique name for the state.
          - {nbt}`string` **on_tick**: Function to call every tick while in this state (optional).
          - {nbt}`string` **on_enter**: Function to call when entering this state (optional).
          - {nbt}`string` **on_exit**: Function to call when exiting this state (optional).
          - {nbt}`bool` **final**: Whether this state is a final state (optional, default: false).
          - {nbt}`list` **transitions**: Array of transition definitions (optional).
            - {nbt}`compound` Transition
              - {nbt}`string` **name**: Name of the transition (optional).
              - {nbt}`string` {nbt}`compound` **condition**: Transition condition. One of the following:
                - {nbt}`compound` Predicate-based transition.
                  - {nbt}`string` **type**: Must be "manual".
                  - {nbt}`string` **wait**: A signal sent manually to the FSM using the `#bs.fsm:emit` feature.
                - {nbt}`compound` Predicate-based transition.
                  - {nbt}`string` **type**: Must be "predicate".
                  - {nbt}`string` **wait**: Predicate to check to trigger the transition.
                - {nbt}`compound` Command-based transition.
                  - {nbt}`string` **type**: Must be "command".
                  - {nbt}`string` **wait**: Command to check to trigger the transition.
                - {nbt}`compound` Hook-based transition.
                  - {nbt}`string` **type**: Must be "hook".
                  - {nbt}`string` **wait**: Hook function to evaluate.
                - {nbt}`compound` Time-based transition.
                  - {nbt}`string` **type**: Must be "delay".
                  - {nbt}`string` **wait**: Time delay in ticks.
              - {nbt}`string` **to**: Name of the target state (must exist in states array).
  :::

:Outputs:
  **Return**: Success (1) if FSM was created successfully, failure (0) otherwise.

  **State**: The FSM is registered and available for use.
```

*Example: Create a simple light FSM with on/off states:*

```mcfunction
# Create a light FSM
function #bs.fsm:new { \
  name: "light_fsm", \
  fsm: { \
    initial: "off", \
    states: [ \
      { \
        name: "off", \
        on_enter: "setblock ~ ~ ~ minecraft:redstone_lamp", \
        transitions: [ \
          { \
            name: "turn_on", \
            condition: "manual", \
            to: "on" \
          } \
        ] \
      }, \
      { \
        name: "on", \
        on_enter: "setblock ~ ~ ~ minecraft:redstone_lamp[lit=true]", \
        transitions: [ \
          { \
            name: "turn_off", \
            condition: "manual", \
            to: "off" \
          } \
        ] \
      } \
    ] \
  } \
}
```

> **Credits**: theogiraudet

---

### Start

:::::{tab-set}
::::{tab-item} Global Instance

```{function} #bs.fsm:start

Start a new global instance of a Finite State Machine.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to instantiate (must exist).
    - {nbt}`string` **instance_name**: Unique identifier for this FSM instance.
  :::

:Outputs:
  **Return**: Success (1) if instance was started successfully, failure (0) otherwise.

  **State**: The FSM instance is created globally and begins execution in its initial state.
```

*Example: Start a light FSM instance:*

```mcfunction
# Start a light FSM instance
function #bs.fsm:start { fsm_name: "light_fsm", instance_name: "main_light" }

# The light FSM is now running globally and will execute its initial state
```

> **Credits**: theogiraudet

::::
::::{tab-item} Local Instance

```{function} #bs.fsm:start_as

Start new local instances of a Finite State Machine bound to the executing entities.
The different commands and predicates used in the FSM will be executed as and at the executing entities.
If the entity is killed during the execution of the FSM, the module will automatically stop the tick commands and transitions evaluation for this entity.

:Inputs:
  **Execution `as <entities>`**: Entities to bind. The entities must not be players.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to instantiate (must exist).
    - {nbt}`string` **instance_name**: Unique identifier for this FSM instance in this context.
  :::

:Outputs:
  **Return**: Success (1) if instance was started successfully, failure (0) otherwise.

  **State**: The FSM instances are created locally for the executing entities and begins execution in their initial state.
```

*Example: Start a light FSM instance for an entity:*

```mcfunction
# Start a light FSM instance bound to the executing entity
execute as @n[type=zombie] run function #bs.fsm:start_as { fsm_name: "light_fsm", instance_name: "entity_light" }

# The light FSM is now running locally for this zombie and will execute its initial state
```

> **Credits**: theogiraudet

::::
:::::

---

### Emit

```{function} #bs.fsm:emit

Emit a signal to a running FSM instance.
This signal may or may not trigger a transition, according to the current state of the FSM instance.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **instance_name**: Name of the FSM instance to emit the signal to.
    - {nbt}`string` **signal**: Name of the signal to emit.
  :::
```

*Example: Emit a signal to a FSM instance:*

```mcfunction
# Emit a signal to a global FSM instance
function #bs.fsm:emit { instance_name: "main_light", signal: "turn_on" }
```

---

### Cancel

```{function} #bs.fsm:cancel

Cancel and stop a running FSM instance.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **instance_name**: Name of the FSM instance to cancel.
    - {nbt}`string` **bind**: Binding type of the instance.
      - **"global"**: Instance is bound globally.
      - **"local"**: Instance is bound to the current execution context.
  :::

:Outputs:
  **Return**: Success (1) if instance was cancelled successfully, failure (0) otherwise.

  **State**: The FSM instance is stopped and cleaned up. If the FSM has an on_cancel function, it will be called.
```

*Example: Cancel a door FSM instance:*

```mcfunction
# Cancel the door FSM instance
function #bs.fsm:cancel { instance_name: "main_door", bind: "global" }

# The door FSM instance is now stopped
```

> **Credits**: theogiraudet

---

### Delete

```{function} #bs.fsm:delete

Delete a Finite State Machine definition and all its instances.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to delete.
  :::

:Outputs:
  **Return**: Success (1) if FSM was deleted successfully, failure (0) otherwise.

  **State**: The FSM definition and all its running instances are removed.
```

*Example: Delete a door FSM:*

```mcfunction
# Delete the door FSM
function #bs.fsm:delete { fsm_name: "door_fsm" }

# The door FSM and all its instances are now removed
```

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
- All transition names must be unique within a state (if specified)

### Acceptability
- The FSM must have at least one final state
- Final states are states marked with `final: true`

### Reachability
- All final states must be reachable from the initial state
- This is determined by analyzing the transition graph

### Transition Validation
- All transition target states must exist in the states array
- Transition conditions must be valid according to their type

---

## 🔄 State Lifecycle

Each state in an FSM follows a specific lifecycle:

1. **Enter**: The `on_enter` function is called when entering the state
2. **Tick**: The `on_tick` function is called every tick while in the state
3. **Transition evaluation**: When a transition condition is met, the state transitions
4. **Exit**: The `on_exit` function is called when leaving the state

---

## ⚡ Transition Types

The FSM system supports several types of transitions:

### Manual
Triggered by external function calls. 
Useful for player interactions or external events.

### Predicate
Triggered when a predicate returns true. 
Useful for conditional logic.

### Command
Triggered when a command succeeds. 
Useful for complex conditions.

### Hook
Triggered by hook system events. 
Useful for integration with other systems.

### Delay
Triggered after a specified time delay. 
Useful for timed behaviors.

---

## ⚠️ Best Practices

1. **Keep states focused**: Each state should represent a single, well-defined behavior
2. **Use meaningful names**: State and transition names should clearly describe their purpose
3. **Handle edge cases**: Always consider what happens when transitions fail
4. **Clean up resources**: Use the on_exit functions to clean up state-specific resources
5. **Define a cancel command**: Use a `on_cancel` command to clean up resources when the FSM is cancelled
