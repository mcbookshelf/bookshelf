# 🖱️ Interaction

**`#bs.interaction:help`**

Attach click and hover events to interaction entities.

```{pull-quote}
"As far as the customer is concerned, the interface is the product."

-- Jef Raskin
```

The module is built on the [interaction](https://minecraft.wiki/w/Interaction) entity: register commands on an interaction, and they run when a player clicks it or looks at it. An interaction can listen to any number of events.

---

## Functions

The following functions are available in this module.

---

### On left click

```{feature} bs.interaction:on_left_click
```

*Example: say hello when a player hits the interaction*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_left_click.in {run:"say Hello",executor:"source",with:{}}

# See the result
# left click the interaction
```

---

### On right click

```{feature} bs.interaction:on_right_click
```

*Example: say hello when a player uses the interaction*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_right_click.in {run:"say Hello",executor:"source",with:{}}

# See the result
# right click the interaction
```

---

### On hover

```{feature} bs.interaction:on_hover
```

*Example: show particles while a player looks at the interaction*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_hover.in {run:"execute at @s run particle minecraft:end_rod ~ ~1 ~",executor:"target",with:{}}

# See the result
# look at the interaction
```

---

### On hover enter

```{feature} bs.interaction:on_hover_enter
```

*Example: make a display glow while a player looks at the interaction*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
summon minecraft:block_display ~-.5 ~ ~-.5 {Tags:["my_pack.icon"],block_state:{Name:"minecraft:slime_block"}}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_hover_enter.in {run:"data modify entity @s Glowing set value true",executor:"@n[tag=my_pack.icon]",with:{lazy:false}}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_hover_leave.in {run:"data modify entity @s Glowing set value false",executor:"@n[tag=my_pack.icon]",with:{lazy:false}}

# See the result
# look at the interaction, then look away
```

---

### On hover leave

```{feature} bs.interaction:on_hover_leave
```

```{admonition} Logging out
:class: warning

The command runs when a player logs out while looking at the interaction. The player is gone by then: `"source"` and `bs.interaction.source` find no one, and the command does not run again when the player comes back.
```

*Example: say goodbye when a player looks away from the interaction*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_hover_leave.in {run:"say Goodbye",executor:"target",with:{}}

# See the result
# look at the interaction, then look away
```

---

### Clear events

```{feature} bs.interaction:clear_events
```

*Example: clear the events registered with an id*

```mcfunction
# Once
summon minecraft:interaction ~ ~ ~ {Tags:["my_pack.button"],width:1f,height:1f}
execute as @n[tag=my_pack.button] run function #bs.interaction:on_hover.in {run:"say Hovered",executor:"target",with:{id:"my_pack:debug"}}
execute as @n[tag=my_pack.button] run function #bs.interaction:clear_events.in {with:{id:"my_pack:debug"}}
```

*Example: clear every hover event*

```mcfunction
execute as @n[tag=my_pack.button] run function #bs.interaction:clear_events.in {with:{type:"hover"}}
```

---

## Entity tags

The following tags are available in this module.

---

### Hovered

**`bs.interaction.hovered`**

Interactions that at least one player looks at.

```{note}
`on_hover_enter` and `on_hover_leave` run for each player. In their command, check this tag to know whether another player still looks at the interaction, such as to make a display glow only while someone looks at it.
```

---

### Source and target

**`bs.interaction.source`**, **`bs.interaction.target`**

While the command of an event runs, the player who triggers it has the `bs.interaction.source` tag, and the interaction has the `bs.interaction.target` tag.

---

```{include} ../_templates/comments.md
```
