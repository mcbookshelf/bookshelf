
# 🖼️ Screen Detection

Help to make geometry stuff!

---

## 🔧 Functions

You can find below all functions available in this module.

---

### 🔧 Errors

If there is not the conditions for a function to run, an error is provided in the storage bs:out geometry.error

---

### get Point

```{function} #bs.geometry:shape/point

Get a point (determined by an origin)

:Inputs:
  **Context position, position will be the origin of the plane
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"point",coord_type:"cartesian",origin} origin are arrays of 3 doubles, origin is the context's position
```


*Example: Get the position of a player (here FooBar):*

```mcfunction
# Once
execute at FooBar run function #bs.geometry:shape/point
```

---

### get Line

```{function} #bs.geometry:shape/line

Get a line (determined by an origin and a unit director vector)

:Inputs:
  **Context position and rotation, position will be the origin of the plane and rotation the direction of the line
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"line",coord_type:"cartesian",origin,k} origin and k are arrays of 3 doubles, origin is the context's position and k is the unit director vector
```


*Example: Get the line sight of a player (here FooBar):*

```mcfunction
# Once
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:shape/line
```

---

### get Plane

```{function} #bs.geometry:shape/line

Get a plane (determined by an origin and a unit normal vector and two orthogonals units directors vectors)

:Inputs:
  **Context position and rotation, position will be the origin of the plane and rotation the direction of the normal
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"line",coord_type:"cartesian",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position, k is the normal vector and i,j the horizontal,vertical director vectors
```


*Example: Get the plane centered at 0 0 0 and facing south :*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:shape/plane
```

---

### Intersect

```{function} #bs.geometry:intersect

Get the intersection of two shapes

:Inputs:
  **Storage bs:in geometry.shapes , and array of 2 shape
:Outputs:
  **Storage bs:out geometry.shape
```


*Example: Get the intersection of the plane centered at 0 0 0 facing south-west and the line sight of a player (here FooBar) :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:shape/plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:shape/line
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:intersect

```

---

### Orthogonal projection

```{function} #bs.geometry:transform/orth_proj

Get the coordinates of the orthogonal projection of a point/line and a plane 

:Inputs:
  **Storage bs:in geometry.shapes , and array of 2 shape, a point/line and a plane
:Outputs:
  **Storage bs:out geometry.shape, a point/line
```


*Example: Get the orthogonal projection of the player position and a plane centered at 0 0 0 facing south-west:*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:shape/plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute at FooBar run function #bs.geometry:shape/point
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:transform/orth_proj
```

---

### Axis Rotation

```{function} #bs.geometry:transform/rot_axis

Get the coordinates of a point with a 3d shapes as reference point (cartesian coord_type only) 

:Inputs:
  **Storage bs:in geometry.shapes , and array of 2 shape, a point and a 3d shape
:Outputs:
  **Storage bs:out geometry.shape, a point
```


*Example: Get the inplane coord of an intersection of the plane centered at 0 0 0 facing south-west and the line sight of a player (here FooBar) :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 0 0 0 rotated 0 45 run function #bs.geometry:shape/plane
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute as FooBar at @s anchored eyes positioned ^ ^ ^ run function #bs.geometry:shape/line
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:intersect
data modify storage bs:in geometry.shapes[1] set from storage bs:out geometry.shape
function #bs.geometry:transform/rot_axis
```

---

### get Cartesian Coord space

```{function} #bs.geometry:coord_space/cartesian

Get a cartesian coord space (point's origin [x,y,z])

:Inputs:
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"coord_space",coord_type:"cartesian",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
```


*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:coord_space/cartesian
```

---

### get Cylindric Coord space

```{function} #bs.geometry:coord_space/cylindric

Get a cylindric coord space (point's origin [yaw,y,r])

:Inputs:
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"coord_space",coord_type:"cylindric",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
```


*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:coord_space/cartesian
```

---

### get Spherical Coord space

```{function} #bs.geometry:coord_space/cartesian

Get a spherical coord space (point's origin [yaw,pitch,r])

:Inputs:
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"coord_space",coord_type:"spherical",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
```


*Example: Get the cartesian coord space of a minecraft world:*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:coord_space/cartesian
```

---

### Coordinate space change

```{function} #bs.geometry:transform/coord_space

Get the coordinates of a point in a coord space

:Inputs:
  **Storage bs:in geometry.shapes , and array of 2 shape, a point and a coord space
:Outputs:
  **Storage bs:out geometry.shape, a point with the targeted coord space
```


*Example: Transform a point of the world into is spheric coord :*

```mcfunction
# Once
data modify storage bs:in geometry.shapes set value []
execute positioned 100 6 -33.2 run function #bs.geometry:shape/point
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
execute positioned 0 0 0 rotated 0 0 run function #bs.geometry:coord_space/spheric
data modify storage bs:in geometry.shapes append from storage bs:out geometry.shape
function #bs.geometry:transform/coord_space
```

---

> **Credits**:  RacoonJohn

---
