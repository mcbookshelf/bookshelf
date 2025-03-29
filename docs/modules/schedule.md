# ⏲️ Schedule

**`#bs.schedule:help`**

Enhance command scheduling with this module, providing flexibility beyond vanilla capabilities. Cancel commands and maintain execution context (entity & location).

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Cancel

:::::{tab-set}
::::{tab-item} All

```{function} #bs.schedule:cancel_all {with:{}}

Cancel all scheduled commands that match the given ID.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Cancel filters.
      - {nbt}`any` **id**: Scheduled command parameter to match against.
  :::
```

*Example: Cancel all commands with an `id` parameter set to "foo":*

```mcfunction
function #bs.schedule:cancel_all {with:{id:"foo"}}
```

::::
::::{tab-item} Single One

```{function} #bs.schedule:cancel_one {with:{}}

Cancel the first scheduled command that matches the given ID.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Cancel filters.
      - {nbt}`any` **id**: Scheduled command parameter to match against.
  :::
```

*Example: Cancel the next command with an `id` parameter set to "foo":*

```mcfunction
function #bs.schedule:cancel_one {with:{id:"foo"}}
```
::::
:::::

> **Credits**: Aksiome, theogiraudet

---

### Clear

```{function} #bs.schedule:clear

Clear all scheduled commands.
```

*Example: Remove all scheduled commands:*

```mcfunction
function #bs.schedule:clear
```

> **Credits**: Aksiome, theogiraudet

---

### Schedule

```{function} #bs.schedule:schedule {run:<command>,with:{}}

Schedule a command for execution.
If a command is registered during a tick where other commands are already scheduled, it is added after those previously registered.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **run**: The command to schedule.
    - {nbt}`compound` **with**: Optional scheduling parameters.
      - {nbt}`any` **id**: Optional identifier for the scheduled command.
      - {nbt}`int` **time**: Delay before execution. Defaults to `1` if not specified.
      - {nbt}`string` **unit**: Time unit (`tick`, `second`, `minute`, `hour`, `t`, `s`, `m`, `h`). Defaults to `tick`.
  :::

:Outputs:
  **Return**: A unique identifier for the scheduled command.
```

*Example: Execute `say foo` in 2 seconds:*

```mcfunction
function #bs.schedule:schedule {run:"say foo",with:{time:2,unit:"s"}}
```

*Example: Schedule then cancel commands that match a complex ID:*

```mcfunction
function #bs.schedule:schedule {run:"say failure",with:{id:{foo:"bar",fails:true},time:10,unit:"s"}}
function #bs.schedule:schedule {run:"say success",with:{id:{foo:"bar"},time:10,unit:"s"}}
function #bs.schedule:cancel_all {with:{id:{fails:true}}}
```

> **Credits**: Aksiome, theogiraudet

---

```{include} ../_templates/comments.md
```
