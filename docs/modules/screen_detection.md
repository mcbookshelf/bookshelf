
# 🖼️ Screen Detection

**`#bs.math:help`**

Help to make nice screens!

---

## 🔧 Functions

You can find below all functions available in this module.

---

### get Line

```{function} #bs.screen_detection:get_line

Compute the intern variables defining the line

:Inputs:
  **Context position and rotation, position will be the origin of the plane and rotation the direction of the line

:Outputs:
  **None
```


*Example: Compute the line sight of a player:*

```mcfunction
# Once
execute as RAC00NJOHN at @s anchored eyes positioned ^ ^ ^ run function bs.screen_detection:get_line
```

### get Plane

```{function} #bs.screen_detection:get_plane

Compute the intern variables defining the plane

:Inputs:
  **Context position and rotation, position will be the origin of the plane and the rotation the normal of the plane

:Outputs:
  **None
```


*Example: Compute the vertical plane facing south centered at 0 0 0 :*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function bs.screen_detection:get_plane
```

---

### plane Coord

```{function} #bs.screen_detection:plane_coord

Compute the inplane coord of the line/plane intersection and the distance of the intersection and line origin

:Inputs:
  **None
  
:Outputs:
  **Return None | scores $dx bs.out $dy bs.out the inplane coord, $dz bs.out the distance
```


*Example: Compute the vertical plane facing south centered at 0 0 0 :*

```mcfunction
# Once
execute positioned 0 0 0 rotated 0 0 run function bs.screen_detection:get_plane
```

---


> **Credits**:  RacoonJohn

---
