
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
  **Context position, position will be the origin of the plane
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"point",coord_type:"cartesian",origin} origin are arrays of 3 doubles, origin is the context's position
```


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
  **Context position and rotation, position will be the origin of the plane and rotation the direction of the line
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"line",coord_type:"cartesian",origin,k} origin and k are arrays of 3 doubles, origin is the context's position and k is the unit director vector
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
  **Context position and rotation, position will be the origin of the plane and rotation the direction of the normal
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.shape {type:"line",coord_type:"cartesian",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position, k is the normal vector and i,j the horizontal,vertical director vectors
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
  **Context position and rotation, position will be the origin of the plane and rotation the direction
  The position should be loaded
  **macro `radius` double
:Outputs:
  **Storage bs:out geometry.shape {type:"sphere",coord_type:"cartesian",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position, i,j,k the horizontal,vertical,depths director vectors
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
  **Storage bs:in geometry.shapes , and array of 2 shape
:Outputs:
  **Storage bs:out geometry.intersect
  **Return the number of intersection
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
  **Storage bs:in geometry.shapes , and array of 2 shape, a point/line and a plane
:Outputs:
  **Storage bs:out geometry.orth_proj, a point/line
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

Get the coordinates of a point with a 3d shapes as reference point (cartesian coord_type only) 

:Inputs:
  **Storage bs:in geometry.shapes , and array of 2 shape, a point and a 3d shape
:Outputs:
  **Storage bs:out geometry.rot_axis, a point
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
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.coord_space {type:"coord_space",coord_type:"cartesian",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
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
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.coord_space {type:"coord_space",coord_type:"cylindric",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
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
  **Context position and rotation, position will be the origin of the coord space and rotation its z-axis (depths)
  The position should be loaded
:Outputs:
  **Storage bs:out geometry.coord_space {type:"coord_space",coord_type:"spherical",origin,i,j,k} origin, i,j,k are arrays of 3 doubles, origin is the context's position and i,j,k the horizontal,vertical,depths director vectors
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
  **Storage bs:in geometry.shapes , and array of 2 shape, a point and a coord space
:Outputs:
  **Storage bs:out geometry.coord_space, a point with the targeted coord space
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
  **Storage bs:in geometry.shapes , and array of 2 shape, a point and a shape
:Outputs:
  **Return and $geometry.sdf bs.out , the signed distance shifted by 3digits (1.234 become 1234)
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

### Signed Distance

Shape definition:

A shape is defined by

- `origin` (coordinate of the center of the shape)
- directors vectors (`i` `j` `k` arrays of double, store the vectors that define the rotation of the shape) (similar to `^i ^j ^k` )
- `coord_type` (string: "cartesian","cylindric","spherical")
- `type` (string: "point","line","plane","coord_space",...)
- `parameters` (array of doubles, the meaning change with the shape)

---
> **Credits**:  RacoonJohn

---
