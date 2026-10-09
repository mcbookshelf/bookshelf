# ⏲️ Schedule

**`#bs.schedule:help`**

Schedule commands that remember which entity and location triggered them, and can be cancelled.

---

## Functions

The following functions are available in this module.

---

### Cancel

:::::{tab-set}
::::{tab-item} All

```{feature} bs.schedule:cancel/all
```

*Example: cancel the commands scheduled with an id, whoever scheduled them*

```mcfunction
# Once
execute as @e[type=minecraft:cow] run function #bs.schedule:schedule/append.in {id:"my_pack:greet",run:"say Hello",time:"5s"}
function #bs.schedule:cancel/all.in {id:"my_pack:greet"}

# See the result
# wait 5 seconds, no cow says hello
```

::::
::::{tab-item} One

```{feature} bs.schedule:cancel/one
```

*Example: cancel the commands the nearest cow scheduled with an id*

```mcfunction
# Once
execute as @e[type=minecraft:cow] run function #bs.schedule:schedule/append.in {id:"my_pack:greet",run:"say Hello",time:"5s"}
execute as @n[type=minecraft:cow] run function #bs.schedule:cancel/one.in {id:"my_pack:greet"}

# See the result
# wait 5 seconds, every cow says hello but the nearest one
```

::::
:::::

---

### Clear

```{feature} bs.schedule:clear
```

*Example: cancel every scheduled command*

```mcfunction
# Once
function #bs.schedule:clear
```

---

### Schedule

:::::{tab-set}
::::{tab-item} Append

```{feature} bs.schedule:schedule/append
```

*Example: say hello twice in 2 seconds*

```mcfunction
# Once
function #bs.schedule:schedule/append.in {id:"my_pack:greet",run:"say Hello",time:"2s"}
function #bs.schedule:schedule/append.in {id:"my_pack:greet",run:"say Hello",time:"2s"}

# See the result
# wait 2 seconds and look at the chat
```

::::
::::{tab-item} Replace

```{feature} bs.schedule:schedule/replace
```

*Example: say hello once, 2 seconds after the last call*

```mcfunction
# Once
function #bs.schedule:schedule/replace.in {id:"my_pack:greet",run:"say Hello",time:"5s"}
function #bs.schedule:schedule/replace.in {id:"my_pack:greet",run:"say Hello",time:"2s"}

# See the result
# wait 2 seconds and look at the chat, nothing more is said after 5 seconds
```

::::
::::{tab-item} Unique

```{feature} bs.schedule:schedule/unique
```

*Example: say hello once in 2 seconds, however many times it is scheduled for that tick*

```mcfunction
# Once
function #bs.schedule:schedule/unique.in {id:"my_pack:greet",run:"say Hello",time:"2s"}
function #bs.schedule:schedule/unique.in {id:"my_pack:greet",run:"say Hello",time:"2s"}

# See the result
# wait 2 seconds and look at the chat
```

::::
:::::

---

```{include} ../_templates/comments.md
```
