# 🧣 Spline

**`#bs.spline:help`**

Manipulate smooth curves created from control points.

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Evaluate

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:evaluate_bezier

Evaluate a Bézier curve using 4 control points and a time parameter.

:Inputs:
  **Storage `bs:in spline.evaluate_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: The 4 control points defining the curve, where each point is an array of coordinates (e.g., 2D, 3D, ...).
    - {nbt}`double` **time**: Position along the curve. Values must be between 0 and 1.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_bezier`**: {nbt}`list` Point at the evaluated time.
```
::::
::::{tab-item} B-Spline

```{function} #bs.spline:evaluate_bspline

Evaluate a B-Spline curve using 4 control points and a time parameter.

:Inputs:
  **Storage `bs:in spline.evaluate_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: The 4 control points defining the curve, where each point is an array of coordinates (e.g., 2D, 3D, ...).
    - {nbt}`double` **time**: Position along the curve. Values must be between 0 and 1.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_bspline`**: {nbt}`list` Point at the evaluated time.
```
::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:evaluate_catmull_rom

Evaluate a Catmull-Rom curve using 4 control points and a time parameter.

:Inputs:
  **Storage `bs:in spline.evaluate_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: The 4 control points defining the curve, where each point is an array of coordinates (e.g., 2D, 3D, ...).
    - {nbt}`double` **time**: Position along the curve. Values must be between 0 and 1.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_catmull_rom`**: {nbt}`list` Point at the evaluated time.
```
::::
::::{tab-item} Hermite

```{function} #bs.spline:evaluate_hermite

Evaluate a Hermite curve using 4 control points and a time parameter.

:Inputs:
  **Storage `bs:in spline.evaluate_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: The 4 control points defining the curve, where each point is an array of coordinates (e.g., 2D, 3D, ...).
    - {nbt}`double` **time**: Position along the curve. Values must be between 0 and 1.
  :::

:Outputs:
  **Storage `bs:out spline.evaluate_hermite`**: {nbt}`list` Point at the evaluated time.
```
::::
:::::

*Evaluate the point in the middle of a Bézier curve in 2D space:*

```mcfunction
data modify storage bs:in spline.evaluate_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],time:0.5}
function #bs.spline:evaluate_bezier
data get storage bs:out spline.evaluate_bezier
```

> **Credits**: Aksiome

### Sample

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:sample_bezier

Sample a Bézier curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with the last point shared between adjacent segments.

:Inputs:
  **Storage `bs:in spline.sample_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares the last point with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_bezier`**: {nbt}`list` Sampled points along the curve.
```
::::
::::{tab-item} B-Spline

```{function} #bs.spline:sample_bspline

Sample a B-Spline curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 3 points shared between adjacent segments.

:Inputs:
  **Storage `bs:in spline.sample_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 3 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_bspline`**: {nbt}`list` Sampled points along the curve.
```
::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:sample_catmull_rom

Sample a Catmull-Rom curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 3 points shared between adjacent segments.

:Inputs:
  **Storage `bs:in spline.sample_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 3 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_catmull_rom`**: {nbt}`list` Sampled points along the curve.
```
::::
::::{tab-item} Hermite

```{function} #bs.spline:sample_hermite

Sample a Hermite curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 2 points shared between adjacent segments.


:Inputs:
  **Storage `bs:in spline.sample_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 2 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
  :::

:Outputs:
  **Storage `bs:out spline.sample_hermite`**: {nbt}`list` Sampled points along the curve.
```
::::
:::::

*Sample 10 points along a Bézier curve in 2D space:*

```mcfunction
data modify storage bs:in spline.sample_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1}
function #bs.spline:sample_bezier
data get storage bs:out spline.sample_bezier
```

> **Credits**: Aksiome

### Stream

:::::{tab-set}
::::{tab-item} Bézier

```{function} #bs.spline:stream_bezier

Stream a Bézier curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with the last point shared between adjacent segments. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_bezier`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares the last point with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: Command executed at each step of the curve sampling process.
  :::
```
::::
::::{tab-item} B-Spline

```{function} #bs.spline:stream_bspline

Stream a B-Spline curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 3 points shared between adjacent segments. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_bspline`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 3 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: Command string executed at each step of the curve sampling process.
  :::

```
::::
::::{tab-item} Catmull-Rom

```{function} #bs.spline:stream_catmull_rom

Stream a Catmull-Rom curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 3 points shared between adjacent segments. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_catmull_rom`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 3 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: Command string executed at each step of the curve sampling process.
  :::
```
::::
::::{tab-item} Hermite

```{function} #bs.spline:stream_hermite

Stream a Hermite curve using control points and a step parameter. Each segment is defined by 4 consecutive points, with 2 points shared between adjacent segments. This function processes each step over multiple ticks.

:Inputs:
  **Storage `bs:in spline.stream_hermite`**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **points**: Control points for the curve, where each segment uses 4 points and shares 2 points with the next.
    - {nbt}`double` **step**: Interval at which the curve is sampled. Smaller values generate more points.
    - {nbt}`string` **run**: Command string executed at each step of the curve sampling process.
  :::
```
::::
:::::

*Stream 10 points along a Bézier curve in 2D space and execute a command at each step:*

```mcfunction
data modify storage bs:in spline.stream_bezier set value {points:[[0,0],[1,2],[2,-1],[3,1]],step:0.1,run:'tellraw @a {"storage":"bs:out","nbt":"spline.stream_bezier"}'}
function #bs.spline:stream_bezier
```

> **Credits**: Aksiome

---

## 🎓 About Splines

Discover how these curves behave through these visual examples. For more in-depth insights into splines, watch [this video](https://www.youtube.com/watch?v=jvPPXbo87ds).

---

::::{grid} 2
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

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
