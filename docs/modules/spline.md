# 🧣 Spline

**`#bs.spline:help`**

Create and manipulate smooth curves from control points.

```{image} /_imgs/modules/spline.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"Do not go where the path may lead, go instead where there is no path and leave a trail."

-- Ralph Waldo Emerson
```

```{admonition} Supported Dimensions
:class: warning

These functions support only 1D, 2D, and 3D splines. If you need to handle more dimensions, you can run multiple 1D splines in parallel for each axis or component.
```

```{admonition} Variable Number of Points
:class: tip

All spline functions in this module accept a variable number of points. You are not restricted to using just four or any fixed count. Splines are built by combining multiple curve segments, so you can define as many points as needed.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Evaluate

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:evaluate_bezier

Evaluate a Bézier spline composed of one or more segments. Each segment is defined by four consecutive control points, with the last point of a segment reused as the first of the next.

:Inputs:
  **Storage `bs:in spline.evaluate_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **time**: A normalized position between 0 and the number of segments. Each integer step moves to the next segment, and the fractional part represents interpolation within that segment.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_bezier`**: {nbt}`list` The interpolated point (1D, 2D, or 3D) on the spline at the given time.
```

*Example: Evaluate the point in the middle of a Bézier curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.evaluate_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],time:0.5}
function #bs.spline:evaluate_bezier
data get storage bs:out spline.evaluate_bezier
```

::::
::::{tab-item} B-Spline

```{function} #bs.spline:evaluate_bspline

Evaluate a B-spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending.

:Inputs:
  **Storage `bs:in spline.evaluate_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **time**: A normalized position between 0 and the number of segments. Each integer step moves to the next segment, and the fractional part represents interpolation within that segment.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_bspline`**: {nbt}`list` The interpolated point (1D, 2D, or 3D) on the spline at the given time.
```

*Example: Evaluate the point in the middle of a B-Spline curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.evaluate_bspline set value {points:[[0,0],[1,2],[2,-1],[3,1]],time:0.5}
function #bs.spline:evaluate_bspline
data get storage bs:out spline.evaluate_bspline
```

::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:evaluate_catmull_rom

Evaluate a Catmull-Rom spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending.

:Inputs:
  **Storage `bs:in spline.evaluate_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **time**: A normalized position between 0 and the number of segments. Each integer step moves to the next segment, and the fractional part represents interpolation within that segment.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_catmull_rom`**: {nbt}`list` The interpolated point (1D, 2D, or 3D) on the spline at the given time.
```

*Example: Evaluate the point in the middle of a Catmull-Rom curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.evaluate_catmull_rom set value {points:[[0,0],[1,2],[2,-1],[3,1]],time:0.5}
function #bs.spline:evaluate_catmull_rom
data get storage bs:out spline.evaluate_catmull_rom
```

::::
::::{tab-item} Hermite

```{function} #bs.spline:evaluate_hermite

Evaluate a Hermite spline composed of one or more segments. Each segment is defined by two positions and their associated tangents, with two points (the second position and its tangent) reused as the first of the next segment. All coordinates and tangents are absolute.

:Inputs:
  **Storage `bs:in spline.evaluate_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **time**: A normalized position between 0 and the number of segments. Each integer step moves to the next segment, and the fractional part represents interpolation within that segment.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_hermite`**: {nbt}`list` The interpolated point (1D, 2D, or 3D) on the spline at the given time.
```

*Example: Evaluate the point in the middle of a Hermite curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.evaluate_hermite set value {points:[[0,0],[1,2],[2,-1],[3,1]],time:0.5}
function #bs.spline:evaluate_hermite
data get storage bs:out spline.evaluate_hermite
```

::::
::::{tab-item} Linear

```{function} #bs.spline:evaluate_linear

Evaluate a linear spline, which connects each pair of consecutive points with a straight segment. There is no curvature; the interpolation is piecewise linear.

:Inputs:
  **Storage `bs:in spline.evaluate_linear`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Each pair of consecutive points defines one linear segment.
    - {nbt}`double` **time**: A normalized position between 0 and the number of segments. Each integer step moves to the next segment, and the fractional part represents interpolation within that segment.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_linear`**: {nbt}`list` The interpolated point (1D, 2D, or 3D) on the spline at the given time.
```

*Example: Evaluate the midpoint between two positions in 2D space:*

```mcfunction
data modify storage bs:in spline.evaluate_linear set value {points:[[0,0],[4,2],[6,5]],time:0.5}
function #bs.spline:evaluate_linear
data get storage bs:out spline.evaluate_linear
```

::::
:::::

> **Credits**: Aksiome

### Sample

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:sample_bezier

Sample a Bézier spline composed of one or more segments. Each segment is defined by four consecutive control points, with the last point of a segment reused as the first of the next.

:Inputs:
  **Storage `bs:in spline.sample_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_bezier`**: {nbt}`list` The sampled points along the spline.
```

*Example: Sample 10 points along a Bézier curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.sample_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1}
function #bs.spline:sample_bezier
data get storage bs:out spline.sample_bezier
```

::::
::::{tab-item} B-Spline

```{function} #bs.spline:sample_bspline

Sample a B-Spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending.

:Inputs:
  **Storage `bs:in spline.sample_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_bspline`**: {nbt}`list` The sampled points along the spline.
```

*Example: Sample 10 points along a B-Spline curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.sample_bspline set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1}
function #bs.spline:sample_bspline
data get storage bs:out spline.sample_bspline
```

::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:sample_catmull_rom

Sample a Catmull-Rom spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending.

:Inputs:
  **Storage `bs:in spline.sample_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_catmull_rom`**: {nbt}`list` The sampled points along the spline.
```

*Example: Sample 10 points along a Catmull-Rom curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.sample_catmull_rom set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1}
function #bs.spline:sample_catmull_rom
data get storage bs:out spline.sample_catmull_rom
```

::::
::::{tab-item} Hermite

```{function} #bs.spline:sample_hermite

Sample a Hermite spline composed of one or more segments. Each segment is defined by two positions and their associated tangents, with two points (the second position and its tangent) reused as the first of the next segment. All coordinates and tangents are absolute.

:Inputs:
  **Storage `bs:in spline.sample_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_hermite`**: {nbt}`list` The sampled points along the spline.
```

*Example: Sample 10 points along a Hermite curve in 2D space ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.sample_hermite set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1}
function #bs.spline:sample_hermite
data get storage bs:out spline.sample_hermite
```

::::
::::{tab-item} Linear

```{function} #bs.spline:sample_linear

Sample a linear spline, which connects each pair of consecutive points with a straight segment.

:Inputs:
  **Storage `bs:in spline.sample_linear`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Each pair of consecutive points defines one linear segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_linear`**: {nbt}`list` The sampled points along the spline.
```

*Example: Sample evenly spaced points along a polyline in 2D space:*

```mcfunction
data modify storage bs:in spline.sample_linear set value {points:[[0,0],[4,2],[6,5]],step:0.25}
function #bs.spline:sample_linear
data get storage bs:out spline.sample_linear
```

::::
:::::

> **Credits**: Aksiome

### Stream

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:stream_bezier

Stream a Bézier spline composed of one or more segments. Each segment is defined by four consecutive control points, with the last point of a segment reused as the first of the next. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: The command executed at each step of the sampling process. For each step, the following storage can be used:
      - **`bs:lambda spline.point`**: The evaluated point.
  :::
```

*Example: Stream 10 points along a Bézier curve in 2D space and execute a command at each step ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.stream_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1,run:'tellraw @a {"storage":"bs:lambda","nbt":"spline.point"}'}
function #bs.spline:stream_bezier
```

::::
::::{tab-item} B-Spline

```{function} #bs.spline:stream_bspline

Stream a B-Spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: The command executed at each step of the sampling process. For each step, the following storage can be used:
      - **`bs:lambda spline.point`**: The evaluated point.
  :::
```

*Example: Stream 10 points along a B-Spline curve in 2D space and execute a command at each step ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.stream_bspline set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1,run:'tellraw @a {"storage":"bs:lambda","nbt":"spline.point"}'}
function #bs.spline:stream_bspline
```

::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:stream_catmull_rom

Stream a Catmull-Rom spline composed of one or more segments. Each segment is defined by four consecutive control points, with three points of a segment reused in the next to ensure smooth blending. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: The command executed at each step of the sampling process. For each step, the following storage can be used:
      - **`bs:lambda spline.point`**: The evaluated point.
  :::
```

*Example: Stream 10 points along a Catmull-Rom curve in 2D space and execute a command at each step ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.stream_catmull_rom set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1,run:'tellraw @a {"storage":"bs:lambda","nbt":"spline.point"}'}
function #bs.spline:stream_catmull_rom
```

::::
::::{tab-item} Hermite

```{function} #bs.spline:stream_hermite

Stream a Hermite spline composed of one or more segments. Each segment is defined by two positions and their associated tangents, with two points (the second position and its tangent) reused as the first of the next segment. All coordinates and tangents are absolute. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every group of 4 consecutive points defines one segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: The command executed at each step of the sampling process. For each step, the following storage can be used:
      - **`bs:lambda spline.point`**: The evaluated point.
  :::
```

*Example: Stream 10 points along a Hermite curve in 2D space and execute a command at each step ([visualize the curve](#about-splines)):*

```mcfunction
data modify storage bs:in spline.stream_hermite set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1,run:'tellraw @a {"storage":"bs:lambda","nbt":"spline.point"}'}
function #bs.spline:stream_hermite
```

::::
::::{tab-item} Linear

```{function} #bs.spline:stream_linear

Stream a linear spline composed of one or more segments. Each segment connects two consecutive control points with a straight line. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_linear`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: A list of coordinates (1D, 2D, or 3D). Every pair of consecutive points defines one linear segment.
    - {nbt}`double` **step**: The interval at which the spline is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: The command executed at each step of the sampling process. For each step, the following storage can be used:
      - **`bs:lambda spline.point`**: The evaluated point.
  :::
```

*Example: Stream 10 points along a linear path in 2D space and execute a command at each step:*

```mcfunction
data modify storage bs:in spline.stream_linear set value {points:[[0,0],[1,2],[3,0]],step:0.1,run:'tellraw @a {"storage":"bs:lambda","nbt":"spline.point"}'}
function #bs.spline:stream_linear
```

::::
:::::

> **Credits**: Aksiome

---

(about-splines)=
## 🎓 About Splines

Discover how these curves behave through these visual examples. For more in-depth insights into splines, watch [this video](https://www.youtube.com/watch?v=jvPPXbo87ds).

---

::::{grid} 1 2 2 2
:::{grid-item-card} Bézier
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/spline/bezier.gif)

:::

:::{grid-item-card} B-Spline
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/spline/bspline.gif)
:::

:::{grid-item-card} Catmull-Rom
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/spline/catmull_rom.gif)
:::

:::{grid-item-card} Hermite
:margin: 0 3 0 0
:text-align: center

![](/_imgs/modules/spline/hermite.gif)
:::
::::

---

```{include} ../_templates/comments.md
```
