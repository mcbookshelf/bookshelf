
# 📐 Geometry

Help to make geometry stuff!

---

## 🔧 Functions

You can find below all functions available in this module.

---

### 🔧 Errors

If there is not the conditions for a function to run, an error is raise in logs

(bs.log module weak dependencies)

---

### get Point

```{function} #bs.geometry:get_point

Get a point (determined by an origin)

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: shape returned

*Example: Get the position of a player (here FooBar):*

```mcfunction
# Once
execute at FooBar run function #bs.geometry:get_point
```

---

### get Line

```{function} #bs.geometry:get_line

Get a line (determined by an origin and a unit director vector)

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit  director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: shape returned
```

*Example: Get the line sight of a player (here FooBar):*

```mcfunction
# Once
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:get_line
```

---

### get Plane

```{function} #bs.geometry:get_line

Get a plane (determined by an origin and a unit normal vector and two orthogonals units directors vectors)

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit  director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: shape returned
```

*Example: Get the plane centered at 0 0 0 and facing south :*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_plane
```

---

### get Sphere

```{function} #bs.geometry:get_sphere

Get a sphere (determined by an origin and a radius)

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit  director vectors **i j k**.
  **The position have to be loaded**
  
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`double`**radius**: radius of the sphere.
  :::

:Outputs:
  **Storage `bs:out geometry.shape`**: shape returned
```

*Example: Get the sphere centered at 0 0 0 and facing south  with a radius of 1block :*

```mcfunction
# Once
scoreboard players set $geometry.shape.sphere.r bs.in 1000
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_sphere
```

---

### Intersect

```{function} #bs.geometry:intersect

Get the intersection of two shapes

:Inputs:
  **Storage `bs:in geometry.shapes`**: list of shapes to intersect

:Outputs:
  **Storage `bs:out geometry.intersect`**: intersection points
```

*Example: Get the intersection of the plane centered at 0 0 0 facing south-west and the line sight of a player (here FooBar) :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:get_plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:get_line
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:intersect

```

---

### Orthogonal projection

```{function} #bs.geometry:project_ortho

Get the coordinates of the orthogonal projection of a point/line and a plane 

:Inputs:
  **Storage `bs:in geometry.shapes`**: list of shapes to project (e.g. a line/plane point/line point/plane)

:Outputs:
  **Storage `bs:out geometry.orth_proj`**: projected shape
```

*Example: Get the orthogonal projection of the player position and a plane centered at 0 0 0 facing south-west:*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:get_plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute at FooBar run function #bs.geometry:get_point
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:project_ortho
```

---

### Axis Rotation

```{function} #bs.geometry:rotate_axis

Get the coordinates of a point with a coord space as reference point (cartesian coord_type only) 

:Inputs:
  **Storage `bs:in geometry.shapes`**: A point and a coord space

:Outputs:
  **Storage `bs:out geometry.rot_axis`**: rotated point
```


*Example: Get the inplane coord of an intersection of the plane centered at 0 0 0 facing south-west and the line sight of a player (here FooBar) :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:get_plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:get_line
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:intersect
data modify storage bs:in geometry.shapes[1] set from storage bs:out geometry.shape
function #bs.geometry:rotate_axis
```

---

### get Cartesian Coord space

```{function} #bs.geometry:get_cartesian_space

Get a cartesian coord space (point's origin [x,y,z])

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: coord space returned
```


*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_cartesian_space
```

---

### get Cylindric Coord space

```{function} #bs.geometry:get_cylindric_space

Get a cylindric coord space (point's origin [yaw,y,r])

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: coord space returned
```

*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_cartesian_space
```

---

### get Spherical Coord space

```{function} #bs.geometry:get_spherical_space

Get a spherical coord space (point's origin [yaw,pitch,r])

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>` and `rotated`**: Position of the **origin** and direction of the unit director vectors **i j k**.
  **The position have to be loaded**

:Outputs:
  **Storage `bs:out geometry.shape`**: coord space returned
```

*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_spherical_space
```

---

### Coordinate space change

```{function} #bs.geometry:convert_space

Get the coordinates of a point in a coord space

:Inputs:
  **Storage `bs:in geometry.shapes`**: A point and a coord space

:Outputs:
  **Storage `bs:out geometry.coord_space`**: converted point
```

*Example: Transform a point of the world into is spheric coord :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 100 6 -33.2 run function #bs.geometry:get_point
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:get_spherical_space
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:convert_space
```

---

### Signed Distance

```{function} #bs.geometry:get_signed_distance

Get the signed distance of a point and a shape

:Inputs:
  **Storage `bs:in geometry.shapes`**: An array of 2 shape, a point and a shape
:Outputs:
  **Return and Scoreboard `$geometry.sdf bs.out`**: The signed distance shifted by 3digits (1.234 become 1234)
```

*Example: get the signed distance of a player (here FooBar) from a line :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute at FooBar run function #bs.geometry:get_point
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute positioned 0 0 0 rotated 30 0 run function #bs.geometry:get_line
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:get_signed_distance
```

---

### Shape Definition
:::{treeview}
  - {nbt}`compound` shape data
    - {nbt}`string`**type**: shape type (e.g. `line` , `point`).
    - {nbt}`string`**coord_type**: the coordinate system used (e.g. `cartesian` , `cylindric`).

    - {nbt}`list`**origin**: X Y Z or YAW Y R or YAW PITCH R coordinates, the origin (e.g. [0d,0d,0d]).
      - {nbt}`double`
    - {nbt}`list`**i**: X Y Z coordinates (support only cartesian), the director unit vector along the x relative axis of the rotation (e.g. [1d,0d,0d]).
      - {nbt}`double`
    - {nbt}`list`**j**: X Y Z coordinates (support only cartesian), the director unit vector along the y relative axis of the rotation (e.g. [0d,1d,0d]).
      - {nbt}`double`
    - {nbt}`list`**k**: X Y Z coordinates (support only cartesian), the director unit vector along the z relative axis of the rotation (e.g. [0d,0d,1d]).
      - {nbt}`double`
      
    - {nbt}`list`**parameters**: parameters of the shape that change with the shape type (e.g. [1d] for the radius of a sphere).
      - {nbt}`double`
  :::

---
> **Credits**:  RacoonJohn

---
