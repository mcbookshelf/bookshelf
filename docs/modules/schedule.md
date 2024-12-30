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

*Cancel all commands that have an `id` parameter set to "foo":*
```mcfunction
function #bs.schedule:cancel_all {with:{id:"foo"}}
```

::::
::::{tab-item} Single One

```{function} #bs.schedule:cancel_one {with:{}}

Cancel the first scheduled command that match the given ID.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Cancel filters.
      - {nbt}`any` **id**: Scheduled command parameter to match against.
  :::
```

*Cancel the next command that have an `id` parameter set to "foo":*
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

*Remove all scheduled commands:*

```mcfunction
function #bs.schedule:clear
```

> **Credits**: Aksiome, theogiraudet

---

### Schedule

```{function} #bs.schedule:schedule {with:{}}

Schedule a command for execution.
If a command is registered in a tick where commands are already registered, adds the command after those already registered.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Schedule data.
      - {nbt}`string` **command**: Command to schedule.
      - {nbt}`int` **time**: Time to wait. In ticks by default if unit is not defined.
      - {nbt}`string` **unit**: Unit of the specified time (tick, second, minute, hour, t, s, m, h).
      - {nbt}`any` **id**: Optional parameter used to identify the scheduled command.
  :::

:Outputs:
  **Return**: A unique identifier for the scheduled command.
```

*Execute `say foo` in 2 seconds:*

```mcfunction
function #bs.schedule:schedule {with:{command:"say foo",time:2,unit:"s"}}
```

*Schedule then cancel commands that match a complex ID:*

```mcfunction
function #bs.schedule:schedule {with:{id:{foo:"bar",fails:true},command:"say failure",time:10,unit:"s"}}
function #bs.schedule:schedule {with:{id:{foo:"bar"},command:"say success",time:10,unit:"s"}}
function #bs.schedule:cancel {with:{id:{fails:true}}}
```

> **Credits**: Aksiome, theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
