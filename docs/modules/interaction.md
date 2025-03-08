# 🖱️ Interaction

**`#bs.interaction:help`**

Create and manage Graphical User Interfaces (GUIs) in Minecraft.

```{epigraph}
"As far as the customer is concerned, the interface is the product."

-- Jef Raskin
```

The Interaction API is a low-level API to create GUIs based on the [Interaction](https://minecraft.wiki/w/Interaction) entity.
This API is low level since the possible events are directly and manually bind to the interaction.

---

## 🔧 Functions

You can find below all functions available in this API.

---

### Clear Events

```{function} #bs.interaction:clear_events

Clear events registered for the specified interaction entity.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the events will be cleared.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`compound` **with**: Parameters to filter which events to clear. Clear all events if empty.
      - {nbt}`string` **type**: Specify the type of events to clear.
      - {nbt}`int` **id**: Specify the ID of events to clear.
  :::

:Outputs:
  **Return**: The number of events removed.

  **State**: The specified events for the interaction entity will be removed.
```

*Clear hover events for the interaction entity:*

```mcfunction
summon minecraft:interaction ~ ~ ~ { Tags: ["bs.entity.interaction"], width: 1f, height: 1f }

# Register hover events for the interaction
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:on_hover { run: "say Hovered", executor: "target" }

# Clear hover events for the interaction
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:clear_events { with: { type: "hover" } }
```

> **Credits**: Aksiome, theogiraudet

---

### On Event

:::::{tab-set}
::::{tab-item} Left Click

```{function} #bs.interaction:on_left_click

Register a command to run when the left click is pressed on the current interaction.
Each interaction can respond to multiple events.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the event is registered.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **run**: Command to execute upon left-click.
    - {nbt}`string` {nbt}`compound` **executor**: Defines the entity on which the command will be executed. Can be either **"source"** for the player who performed the action or **"target"** for the interaction entity itself. A compound can also be used to target other entities:
      - {nbt}`string` **selector**: Specifies entities for the command execution (`execute as <entity>`).
      - {nbt}`bool` **lazy**: Determines whether to resolve the selector immediately (`false`) or at runtime (`true`, default). If `false`, the selector must target only one entity, replacing the selector with that entity’s UUID. Useful for optimizing execution, especially when targeting graphical representations. If multiple entities are targeted, the first one is selected.
  :::

:Outputs:
  **Return**: The ID of the created event.

  **State**: The interaction will trigger the event when left clicked.
```
::::
::::{tab-item} Right Click

```{function} #bs.interaction:on_right_click

Register a command to run when the right click is pressed on the current interaction.
Each interaction can respond to multiple events.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the event is registered.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`string` **run**: Command to execute upon right-click.
    - {nbt}`string` {nbt}`compound` **executor**: Defines the entity on which the command will be executed. Can be either **"source"** for the player who performed the action or **"target"** for the interaction entity itself. A compound can also be used to target other entities:
      - {nbt}`string` **selector**: Specifies entities for the command execution (`execute as <entity>`).
      - {nbt}`bool` **lazy**: Determines whether to resolve the selector immediately (`false`) or at runtime (`true`, default). If `false`, the selector must target only one entity, replacing the selector with that entity’s UUID. Useful for optimizing execution, especially when targeting graphical representations. If multiple entities are targeted, the first one is selected.
  :::

:Outputs:
  **Return**: The ID of the created event.

  **State**: The interaction will trigger the event when right clicked.
```
::::
::::{tab-item} Hover

```{function} #bs.interaction:on_hover

Register a command to run continuously while the player is hovering over the interaction.
Each interaction can respond to multiple events.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the event is registered.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`string` **run**: Command to execute while hovering over the interaction.
    - {nbt}`string` {nbt}`compound` **executor**: Defines the entity on which the command will be executed. Can be either **"source"** for the player who performed the action or **"target"** for the interaction entity itself. A compound can also be used to target other entities:
      - {nbt}`string` **selector**: Specifies entities for the command execution (`execute as <entity>`).
      - {nbt}`bool` **lazy**: Determines whether to resolve the selector immediately (`false`) or at runtime (`true`, default). If `false`, the selector must target only one entity, replacing the selector with that entity’s UUID. Useful for optimizing execution, especially when targeting graphical representations. If multiple entities are targeted, the first one is selected.
  :::

:Outputs:
  **Return**: The ID of the created event.

  **State**: The interaction will trigger the event continuously while hovered over.
```
::::
::::{tab-item} Enter Hover

```{function} #bs.interaction:on_hover_enter

Register a command to run once when the player begins hovering over the interaction.
Each interaction can respond to multiple events.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the event is registered.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`string` **run**: Command to execute when hovering begins.
    - {nbt}`string` {nbt}`compound` **executor**: Defines the entity on which the command will be executed. Can be either **"source"** for the player who performed the action or **"target"** for the interaction entity itself. A compound can also be used to target other entities:
      - {nbt}`string` **selector**: Specifies entities for the command execution (`execute as <entity>`).
      - {nbt}`bool` **lazy**: Determines whether to resolve the selector immediately (`false`) or at runtime (`true`, default). If `false`, the selector must target only one entity, replacing the selector with that entity’s UUID. Useful for optimizing execution, especially when targeting graphical representations. If multiple entities are targeted, the first one is selected.
  :::

:Outputs:
  **Return**: The ID of the created event.

  **State**: The interaction will trigger the event once upon hover entry.
```
::::
::::{tab-item} Leave Hover

```{function} #bs.interaction:on_hover_leave

Register a command to run once when the player stops hovering over the interaction.
Each interaction can respond to multiple events.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the event is registered.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`string` **run**: Command to execute when hovering ends.
    - {nbt}`string` {nbt}`compound` **executor**: Defines the entity on which the command will be executed. Can be either **"source"** for the player who performed the action or **"target"** for the interaction entity itself. A compound can also be used to target other entities:
      - {nbt}`string` **selector**: Specifies entities for the command execution (`execute as <entity>`).
      - {nbt}`bool` **lazy**: Determines whether to resolve the selector immediately (`false`) or at runtime (`true`, default). If `false`, the selector must target only one entity, replacing the selector with that entity’s UUID. Useful for optimizing execution, especially when targeting graphical representations. If multiple entities are targeted, the first one is selected.
  :::

:Outputs:
  **Return**: The ID of the created event.

  **State**: The interaction will trigger the event once upon hover exit.
```


```{admonition} Edge Case
:class: warning

If a player logs out while hovering over the interaction, the hover leave event will trigger on the executor. If the executor is the player, the event won’t be triggered again when they log back in. Be sure to account for this edge case and handle it appropriately when the player returns.
```

::::
:::::

*Glow the interaction's icon while the interaction is hovered and unglow it when it is not hovered anymore:*

```mcfunction
summon minecraft:interaction ~ ~ ~ { Tags: ["bs.entity.interaction"], width: 1f, height: 1f }
summon block_display ~-.5 ~ ~-.5 { Tags: ["bs.entity.block_display"], width: 1f, height: 1f, block_state: { Name: "minecraft:slime_block" }}

# Callback to glow the icon when the interaction is hovered
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:on_hover_enter { run: "function #bs.interaction:callback/glow", executor: { selector: "@e[tag=bs.entity.block_display]", lazy: false } }
# Callback to unglow the icon when the interaction is not hovered anymore
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:on_hover_leave { run: "function #bs.interaction:callback/unglow", executor: { selector: "@e[tag=bs.entity.block_display]", lazy: false } }
```

> **Credits**: Aksiome, theogiraudet

---

### Predefined Callbacks

:::::{tab-set}
::::{tab-item} Glow
**`#bs.interaction:callback/glow`**

Makes the target entity glow.
::::

::::{tab-item} Unglow
**`#bs.interaction:callback/unglow`**

Removes the glow effect from the target entity.
::::

::::{tab-item} None
**`#bs.interaction:callback/none`**

An empty callback that does nothing. May be used as a placeholder or to explicitly indicate that no action should occur.
::::
:::::

---

## 🏷️ Entity Tags

You can find below all tags available in this API.

---

### Is Hovered?

**`bs.interaction.hovered`**

Determine if an interaction is currently hovered by a player.

```{note}
This is useful in `hover_enter` and `hover_leave` events, which are per player. Since `hover_leave` triggers when a player stops hovering but doesn't check if all players have stopped, this tag can be used to determine when every player has left the interaction.
```

> **Credits**: Aksiome

---

### Is Source?

**`bs.interaction.source`**

Usable only in the callback of an event.
Determine if the current entity is the source of the event.

> **Credits**: theogiraudet

---

### Is Target?

**`bs.interaction.target`**

Usable only in the callback of an event.
Determine if the current entity is the target of the event.

> **Credits**: theogiraudet

---

### Listen to a Specific Event?

:::::{tab-set}
::::{tab-item} Right Click

**`bs.interaction.listen_right_click`**


Determine if the current interaction listen to right click interaction.
::::
::::{tab-item} Left Click

**`bs.interaction.listen_left_click`**

Determine if the current interaction listen to left click interaction.
::::
::::{tab-item} Hover

**`bs.interaction.listen_hover`**

Determine if the current interaction listen to hover interaction.
::::
::::{tab-item} Enter Hover

**`bs.interaction.listen_hover_enter`**

Determine if the current interaction listen to enter hover interaction.
::::
::::{tab-item} Leave Hover

**`bs.interaction.listen_hover_leave`**

Determine if the current interaction listen to leave hover interaction.
::::
:::::

> **Credits**: theogiraudet

---

```{include} ../_templates/comments.md
```
