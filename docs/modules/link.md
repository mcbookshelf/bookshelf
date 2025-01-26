# 🔗 Link

**`#bs.link:help`**

Construct coherent entity structures by linking entities' positions and rotations.

```{image} /_imgs/modules/link.png
:align: center
:class: dark_light
```

```{epigraph}
"Invisible threads are the strongest ties."

-- Friedrich Nietzsche
```

```{important}
This module uses scaled integers and can overflow when coordinates are higher than 2,000,000.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Create Link

```{function} #bs.link:create_link_ata

Create a link between the entity executing the function and the entity closest to the execution position.

:Inputs:
  **Execution `as <entities>`**: Child entities that you wish to link to a parent.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Use the nearest entity as the parent.

:Outputs:
  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

  **Scores `@s bs.link.l[x,y,z,h,v]`**: Local position and rotation relative to the parent entity.

  **Scores `@s bs.link.to`**: ID of the parent entity to which it is linked.
```

*Link armor stands to the nearest sheep:*
```mcfunction
# Once
execute as @e[type=armor_stand] at @e[type=sheep,limit=1,sort=nearest] run function #bs.link:create_link_ata
```

```{important}
You should generally avoid changing output scores, as they serve as parameters for other link functions. Therefore, it is recommended to exclusively let Bookshelf handle them.
```

> **Credits**: Aksiome, Leirof

---

### Imitate Behaviors

::::{tab-set}
:::{tab-item} Pos & Rot

```{function} #bs.link:imitate_pos_and_rot

Replace the entity at its relative position and local rotation. This operation repeated in a loop simulates the movements and rotations of the parent entity.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

  **Scores `@s bs.link.l[h,v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its relative position and local rotation relative to the parent entity.
```

*Make armor stands mimic your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_pos_and_rot
```

:::
:::{tab-item} Position

```{function} #bs.link:imitate_pos

Replace the entity at its relative position. This operation repeated in a loop simulates the movements of the parent entity.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its relative position with the parent entity.
```

*Make armor stands mimic your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_pos
```

:::
:::{tab-item} Rotation

```{function} #bs.link:imitate_rot

Replace the entity at its local rotation. This operation repeated in a loop simulates the rotation of the parent entity.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.l[h,v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its local rotation relative to the parent entity.
```

*Make armor stands mimic your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_rot
```

:::
:::{tab-item} Single Axis

```{function} #bs.link:imitate_pos_[x|y|z]

Replace the entity at its relative position along an axis. This operation repeated in a loop simulates the movements of the parent entity on a single axis.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Score `@s bs.link.r[x|y|z]`**: Relative position to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its relative position with the parent entity on a single axis.
```

*Make armor stands mimic your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_pos_x
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_pos_y
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_pos_z
```

:::
:::{tab-item} Single Angle

```{function} #bs.link:imitate_rot_[h|v]

Replace the entity at its horizontal or vertical local rotation. This operation repeated in a loop simulates the rotation of the parent entity on a single rotation axis.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Score `@s bs.link.l[h|v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its local rotation relative to the parent entity on a single rotation axis.
```

*Make armor stands mimic your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_rot_h
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:imitate_rot_v
```

:::
::::

```{important}
While chaining behavior functions is possible, it's not advisable because it involves repeatedly fetching coordinates, performing computations, and applying them. Instead, consider creating [custom behaviors](#custom-behaviors).
```

> **Credits**: Aksiome, Leirof

---

### Keep Local Position

```{function} #bs.link:keep_local_pos

Keep the local position relative to the parent entity.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.l[x,y,z]`**: Local position relative to the parent entity.

:Outputs:
  **State**: The entity is moved to maintain its local position relative to the parent entity.
```

*Make armor stands lock to your rotation:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:keep_local_pos
```

```{admonition} Local Position... 🥶 What's this?
:class: dropdown

Unlike relative coordinates, this reference frame considers the entity's rotation. Therefore, when the parent entity rotates, the child entity rotates around it. For those familiar with Minecraft commands, local coordinates are available through the `^` symbol.
```

> **Credits**: Aksiome, Leirof

---

### Mirror Plane

```{function} #bs.link:mirror_[x|z]_plane

Mirror the position and rotation of an entity along a plane.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

  **Scores `@s bs.link.l[h,v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is moved such as it mirrors the relative position and rotation of the parent entity.
```

*Make armor stands mirror your position and rotation along a plane:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:mirror_x_plane
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:mirror_z_plane
```

> **Credits**: Aksiome

---

### Mirror Point

```{function} #bs.link:mirror_point_ata

Mirror the position and rotation of an entity around a given point.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the point around which the entity is mirrored.

:Outputs:
  **State**: The entity is moved such as it mirrors the position and rotation of the the parent entity around the given point.
```

*Make armor stands mirror your position and rotation around 0 0 0:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] positioned 0 0 0 run function #bs.link:mirror_point_ata
```

> **Credits**: Aksiome

---

### Relationships

::::{tab-set}
:::{tab-item} As Children

```{function} #bs.link:as_children {run:<command>}

Execute a command as child entities linked to the executing parent entity.

:Inputs:
  **Execution `as <entities>`**: Execute as parent entities that must have valid child entities.

:Outputs:
  **Return**: Fails if the execution entity has no linked child entities.
```

*Execute a command as all armor stand children:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata
function #bs.link:as_children {run:"say Hello World"}
```

:::
:::{tab-item} As Parent

```{function} #bs.link:as_children {run:<command>}

Execute a command as the parent entity linked to the executing child entity.

:Inputs:
  **Execution `as <entities>`**: Execute as child entities that must have a valid parent entity.

:Outputs:
  **Return**: Fails if the execution entity has no linked parent entity.
```

*Execute a command as the parent of an armor stand:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata
execute as @n[type=armor_stand] run function #bs.link:as_parent {run:"say Hello World"}
```

:::
:::{tab-item} At Children

```{function} #bs.link:as_children {run:<command>}

Execute a command at the location of child entities linked to the executing parent entity.

:Inputs:
  **Execution `as <entities>`**: Execute as parent entities that must have valid child entities.

:Outputs:
  **Return**: Fails if the execution entity has no linked child entities.
```

*Execute a command at the location of all armor stand children:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata
function #bs.link:at_children {run:"summon lightning_bolt"}
```

:::
:::{tab-item} At Parent

```{function} #bs.link:as_children {run:<command>}

Execute a command at the location of the parent entity linked to the executing child entity.

:Inputs:
  **Execution `as <entities>`**: Execute as child entities that must have a valid parent entity.

:Outputs:
  **Return**: Fails if the execution entity has no linked parent entity.
```

*Execute a command at the location of the parent of an armor stand:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata
execute as @n[type=armor_stand] run function #bs.link:at_parent {run:"summon lightning_bolt"}
```

:::
::::

> **Credits**: Aksiome

---

### Remove Link

```{function} #bs.link:remove_link

Removes an existing link between entities. When executed on a parent entity, it removes all child entities from the link. It does not reset the `bs.id` of entities.

:Inputs:
  **Execution `as <entities>`**: Child or parent entities that you want to unlink.

:Outputs:
  **Scores `<children> bs.link.[...]`**: Resets all link-related scores.
```

*Unlink the nearest armor stand from a sheep:*
```mcfunction
# Once
execute as @e[type=armor_stand] at @e[type=sheep,limit=1,sort=nearest] run function #bs.link:create_link_ata
execute as @n[type=armor_stand] run function #bs.link:remove_link
```

> **Credits**: Aksiome

---

### Reverse Behaviors

::::{tab-set}
:::{tab-item} Pos & Rot

```{function} #bs.link:reverse_pos_and_rot

Determine the rotation and movement made by the parent entity, and reproduce them in the opposite direction.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

  **Scores `@s bs.link.l[h,v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is moved and rotated opposingly to the movements and rotations of the parent entity.
```

*Make armor stands invert your moves and rotations:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_pos_and_rot
```

:::
:::{tab-item} Position

```{function} #bs.link:reverse_pos

Determine the movement made by the parent entity, and reproduce it in the opposite direction.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

:Outputs:
  **State**: The entity is moved opposingly to the movements of the parent entity.
```

*Make armor stands do the opposite of your moves:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_pos
```

:::
:::{tab-item} Rotation

```{function} #bs.link:reverse_rot

Determine the rotation performed by the parent entity, and reproduce it in the opposite direction.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Scores `@s bs.link.l[h,v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is rotated opposingly to the rotations of the parent entity.
```

*Make armor stands invert your rotations:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_rot
```

:::
:::{tab-item} Single Axis

```{function} #bs.link:reverse_pos_[x|y|z]

Determine the movement made by the parent entity along a single axis, and reproduce it in the opposite direction.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Score `@s bs.link.r[x|y|z]`**: Relative position to the parent entity.

:Outputs:
  **State**: The entity is moved opposingly to the movements of the parent entity along a single axis.
```

*Make armor stands do the opposite of your moves along an axis:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_pos_x
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_pos_y
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_pos_z
```

:::
:::{tab-item} Single Angle

```{function} #bs.link:reverse_rot_[h|v]

Determine the rotation performed by the parent entity along a rotation axis, and reproduce it in the opposite direction.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

  **Score `@s bs.link.l[h|v]`**: Local rotation relative to the parent entity.

:Outputs:
  **State**: The entity is rotated opposingly to the rotations of the parent entity.
```

*Make armor stands invert your rotations along a rotation axis:*

```mcfunction
# Once
execute as @e[type=armor_stand] run function #bs.link:create_link_ata

# In a loop
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_rot_h
# Or
execute as @e[predicate=bs.link:has_link] run function #bs.link:reverse_rot_v
```

:::
::::

```{important}
While chaining behavior functions is possible, it's not advisable because it involves repeatedly fetching coordinates, performing computations, and applying them. Instead, consider creating [custom behaviors](#custom-behaviors).
```

> **Credits**: Aksiome, Leirof

---

### Update Link

```{function} #bs.link:update_link

Update scores that represent the link between an entity and its parent.

:Inputs:
  **Execution `as <entities>`**: Executing entities that must be linked to another entity.

:Outputs:
  **Scores `@s bs.link.r[x,y,z]`**: Relative position to the parent entity.

  **Scores `@s bs.link.l[x,y,z,h,v]`**: Local position and rotation relative to the parent entity.
```

*Update armor stands link:*

```mcfunction
# Once
execute as @e[type=armor_stand,predicate=bs.link:has_link] run function #bs.link:update_link
```

```{important}
You usually don't need to call this function while using others. However, if you move a child entity and want to maintain the new connection it forms with the parent, updating the link is necessary to prevent changes from being reversed.
```

> **Credits**: Aksiome, Leirof

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Has Link

**`bs.link:has_link`**

Determine if an entity has a `bs.link.to` score.

> **Credits**: Aksiome

---

### Link Equal

```{function} bs.link:link_equal

Find an entity that has the same `bs.link.to` as the input value.

:Inputs:
  **Score `$link.to bs.in`**: Value to check against.
```

*Find the entity that has a `bs.link.to` equal to 1:*

```mcfunction
scoreboard players set $link.to bs.in 1
execute as @n[predicate=bs.link:link_equal] run say I'm the one
```
> **Credits**: Aksiome

---

(custom-behaviors)=
## 🎓 Custom Behaviors

This module allows you to combine multiple behaviors to create your very own optimized custom one.

---

To create a new behavior, you first need to create a new function tag. The tag must start with `#bs.link:behaviors/setup` and end with `#bs.link:behaviors/apply`. Between those 2 functions you are free to use any behaviors that are provided inside the `#bs.link:behaviors` folder.



*This is how `#bs.link:mirror_x_plane` is implemented inside bookshelf:*

```json
{
  "values": [
    "#bs.link:behaviors/setup",
    "#bs.link:behaviors/reverse_pos_x",
    "#bs.link:behaviors/imitate_pos_y",
    "#bs.link:behaviors/imitate_pos_z",
    "#bs.link:behaviors/reverse_rot_h",
    "#bs.link:behaviors/imitate_rot_v",
    "#bs.link:behaviors/apply"
  ]
}
```
---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
