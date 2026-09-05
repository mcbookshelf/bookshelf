# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:ward animation.bake.f_bezier_1d set value {run:"function #bs.animation:callback/pos",basis:"bezier",duration:20,points:[[0d],[2.5d],[3.25d],[-1.75d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bezier_1d"}
assert data storage bs:ward animation.bake.f_bezier_1d._[{f:"1d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bezier_1d._[0].f
assert data storage bs:ward animation.bake.f_bezier_1d._[0].p[3]
assert not data storage bs:ward animation.bake.f_bezier_1d._[0].p[4]
assert data storage bs:ward animation.bake.f_bezier_1d._[0]
assert not data storage bs:ward animation.bake.f_bezier_1d._[1]

data modify storage bs:ward animation.bake.f_bezier_2d set value {run:"function #bs.animation:callback/pos",basis:"bezier",duration:20,points:[[0d,1d],[2.5d,-0.5d],[3.25d,2d],[-1.75d,3.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bezier_2d"}
assert data storage bs:ward animation.bake.f_bezier_2d._[{f:"2d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bezier_2d._[0].f
assert data storage bs:ward animation.bake.f_bezier_2d._[0].p[7]
assert not data storage bs:ward animation.bake.f_bezier_2d._[0].p[8]
assert data storage bs:ward animation.bake.f_bezier_2d._[0]
assert not data storage bs:ward animation.bake.f_bezier_2d._[1]

data modify storage bs:ward animation.bake.f_bezier_3d set value {run:"function #bs.animation:callback/pos",basis:"bezier",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d],[3.25d,2d,-2d],[-1.75d,3.5d,3d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bezier_3d"}
assert data storage bs:ward animation.bake.f_bezier_3d._[{f:"3d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bezier_3d._[0].f
assert data storage bs:ward animation.bake.f_bezier_3d._[0].p[11]
assert not data storage bs:ward animation.bake.f_bezier_3d._[0].p[12]
assert data storage bs:ward animation.bake.f_bezier_3d._[0]
assert not data storage bs:ward animation.bake.f_bezier_3d._[1]

data modify storage bs:ward animation.bake.f_bspline_1d set value {run:"function #bs.animation:callback/pos",basis:"bspline",duration:20,points:[[0d],[2.5d],[3.25d],[-1.75d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bspline_1d"}
assert data storage bs:ward animation.bake.f_bspline_1d._[{f:"1d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bspline_1d._[0].f
assert data storage bs:ward animation.bake.f_bspline_1d._[0].p[3]
assert not data storage bs:ward animation.bake.f_bspline_1d._[0].p[4]
assert data storage bs:ward animation.bake.f_bspline_1d._[0]
assert not data storage bs:ward animation.bake.f_bspline_1d._[1]

data modify storage bs:ward animation.bake.f_bspline_2d set value {run:"function #bs.animation:callback/pos",basis:"bspline",duration:20,points:[[0d,1d],[2.5d,-0.5d],[3.25d,2d],[-1.75d,3.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bspline_2d"}
assert data storage bs:ward animation.bake.f_bspline_2d._[{f:"2d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bspline_2d._[0].f
assert data storage bs:ward animation.bake.f_bspline_2d._[0].p[7]
assert not data storage bs:ward animation.bake.f_bspline_2d._[0].p[8]
assert data storage bs:ward animation.bake.f_bspline_2d._[0]
assert not data storage bs:ward animation.bake.f_bspline_2d._[1]

data modify storage bs:ward animation.bake.f_bspline_3d set value {run:"function #bs.animation:callback/pos",basis:"bspline",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d],[3.25d,2d,-2d],[-1.75d,3.5d,3d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_bspline_3d"}
assert data storage bs:ward animation.bake.f_bspline_3d._[{f:"3d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_bspline_3d._[0].f
assert data storage bs:ward animation.bake.f_bspline_3d._[0].p[11]
assert not data storage bs:ward animation.bake.f_bspline_3d._[0].p[12]
assert data storage bs:ward animation.bake.f_bspline_3d._[0]
assert not data storage bs:ward animation.bake.f_bspline_3d._[1]

data modify storage bs:ward animation.bake.f_catmull_rom_1d set value {run:"function #bs.animation:callback/pos",basis:"catmull_rom",duration:20,points:[[0d],[2.5d],[3.25d],[-1.75d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_catmull_rom_1d"}
assert data storage bs:ward animation.bake.f_catmull_rom_1d._[{f:"1d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_catmull_rom_1d._[0].f
assert data storage bs:ward animation.bake.f_catmull_rom_1d._[0].p[3]
assert not data storage bs:ward animation.bake.f_catmull_rom_1d._[0].p[4]
assert data storage bs:ward animation.bake.f_catmull_rom_1d._[0]
assert not data storage bs:ward animation.bake.f_catmull_rom_1d._[1]

data modify storage bs:ward animation.bake.f_catmull_rom_2d set value {run:"function #bs.animation:callback/pos",basis:"catmull_rom",duration:20,points:[[0d,1d],[2.5d,-0.5d],[3.25d,2d],[-1.75d,3.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_catmull_rom_2d"}
assert data storage bs:ward animation.bake.f_catmull_rom_2d._[{f:"2d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_catmull_rom_2d._[0].f
assert data storage bs:ward animation.bake.f_catmull_rom_2d._[0].p[7]
assert not data storage bs:ward animation.bake.f_catmull_rom_2d._[0].p[8]
assert data storage bs:ward animation.bake.f_catmull_rom_2d._[0]
assert not data storage bs:ward animation.bake.f_catmull_rom_2d._[1]

data modify storage bs:ward animation.bake.f_catmull_rom_3d set value {run:"function #bs.animation:callback/pos",basis:"catmull_rom",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d],[3.25d,2d,-2d],[-1.75d,3.5d,3d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_catmull_rom_3d"}
assert data storage bs:ward animation.bake.f_catmull_rom_3d._[{f:"3d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_catmull_rom_3d._[0].f
assert data storage bs:ward animation.bake.f_catmull_rom_3d._[0].p[11]
assert not data storage bs:ward animation.bake.f_catmull_rom_3d._[0].p[12]
assert data storage bs:ward animation.bake.f_catmull_rom_3d._[0]
assert not data storage bs:ward animation.bake.f_catmull_rom_3d._[1]

data modify storage bs:ward animation.bake.f_hermite_1d set value {run:"function #bs.animation:callback/pos",basis:"hermite",duration:20,points:[[0d],[2.5d],[3.25d],[-1.75d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_hermite_1d"}
assert data storage bs:ward animation.bake.f_hermite_1d._[{f:"1d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_hermite_1d._[0].f
assert data storage bs:ward animation.bake.f_hermite_1d._[0].p[3]
assert not data storage bs:ward animation.bake.f_hermite_1d._[0].p[4]
assert data storage bs:ward animation.bake.f_hermite_1d._[0]
assert not data storage bs:ward animation.bake.f_hermite_1d._[1]

data modify storage bs:ward animation.bake.f_hermite_2d set value {run:"function #bs.animation:callback/pos",basis:"hermite",duration:20,points:[[0d,1d],[2.5d,-0.5d],[3.25d,2d],[-1.75d,3.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_hermite_2d"}
assert data storage bs:ward animation.bake.f_hermite_2d._[{f:"2d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_hermite_2d._[0].f
assert data storage bs:ward animation.bake.f_hermite_2d._[0].p[7]
assert not data storage bs:ward animation.bake.f_hermite_2d._[0].p[8]
assert data storage bs:ward animation.bake.f_hermite_2d._[0]
assert not data storage bs:ward animation.bake.f_hermite_2d._[1]

data modify storage bs:ward animation.bake.f_hermite_3d set value {run:"function #bs.animation:callback/pos",basis:"hermite",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d],[3.25d,2d,-2d],[-1.75d,3.5d,3d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_hermite_3d"}
assert data storage bs:ward animation.bake.f_hermite_3d._[{f:"3d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_hermite_3d._[0].f
assert data storage bs:ward animation.bake.f_hermite_3d._[0].p[11]
assert not data storage bs:ward animation.bake.f_hermite_3d._[0].p[12]
assert data storage bs:ward animation.bake.f_hermite_3d._[0]
assert not data storage bs:ward animation.bake.f_hermite_3d._[1]

data modify storage bs:ward animation.bake.f_smooth_1d set value {run:"function #bs.animation:callback/pos",basis:"smooth",duration:20,points:[[0d],[2.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_smooth_1d"}
assert data storage bs:ward animation.bake.f_smooth_1d._[{f:"1d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_smooth_1d._[0].f
assert data storage bs:ward animation.bake.f_smooth_1d._[0].p[3]
assert not data storage bs:ward animation.bake.f_smooth_1d._[0].p[4]
assert data storage bs:ward animation.bake.f_smooth_1d._[0]
assert not data storage bs:ward animation.bake.f_smooth_1d._[1]

data modify storage bs:ward animation.bake.f_smooth_2d set value {run:"function #bs.animation:callback/pos",basis:"smooth",duration:20,points:[[0d,1d],[2.5d,-0.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_smooth_2d"}
assert data storage bs:ward animation.bake.f_smooth_2d._[{f:"2d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_smooth_2d._[0].f
assert data storage bs:ward animation.bake.f_smooth_2d._[0].p[7]
assert not data storage bs:ward animation.bake.f_smooth_2d._[0].p[8]
assert data storage bs:ward animation.bake.f_smooth_2d._[0]
assert not data storage bs:ward animation.bake.f_smooth_2d._[1]

data modify storage bs:ward animation.bake.f_smooth_3d set value {run:"function #bs.animation:callback/pos",basis:"smooth",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_smooth_3d"}
assert data storage bs:ward animation.bake.f_smooth_3d._[{f:"3d/cubic"}]
assert result 8 run data get storage bs:ward animation.bake.f_smooth_3d._[0].f
assert data storage bs:ward animation.bake.f_smooth_3d._[0].p[11]
assert not data storage bs:ward animation.bake.f_smooth_3d._[0].p[12]
assert data storage bs:ward animation.bake.f_smooth_3d._[0]
assert not data storage bs:ward animation.bake.f_smooth_3d._[1]

data modify storage bs:ward animation.bake.f_linear_1d set value {run:"function #bs.animation:callback/pos",basis:"linear",duration:20,points:[[0d],[2.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_linear_1d"}
assert data storage bs:ward animation.bake.f_linear_1d._[{f:"1d/linear"}]
assert result 9 run data get storage bs:ward animation.bake.f_linear_1d._[0].f
assert data storage bs:ward animation.bake.f_linear_1d._[0].p[1]
assert not data storage bs:ward animation.bake.f_linear_1d._[0].p[2]
assert data storage bs:ward animation.bake.f_linear_1d._[0]
assert not data storage bs:ward animation.bake.f_linear_1d._[1]

data modify storage bs:ward animation.bake.f_linear_2d set value {run:"function #bs.animation:callback/pos",basis:"linear",duration:20,points:[[0d,1d],[2.5d,-0.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_linear_2d"}
assert data storage bs:ward animation.bake.f_linear_2d._[{f:"2d/linear"}]
assert result 9 run data get storage bs:ward animation.bake.f_linear_2d._[0].f
assert data storage bs:ward animation.bake.f_linear_2d._[0].p[3]
assert not data storage bs:ward animation.bake.f_linear_2d._[0].p[4]
assert data storage bs:ward animation.bake.f_linear_2d._[0]
assert not data storage bs:ward animation.bake.f_linear_2d._[1]

data modify storage bs:ward animation.bake.f_linear_3d set value {run:"function #bs.animation:callback/pos",basis:"linear",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_linear_3d"}
assert data storage bs:ward animation.bake.f_linear_3d._[{f:"3d/linear"}]
assert result 9 run data get storage bs:ward animation.bake.f_linear_3d._[0].f
assert data storage bs:ward animation.bake.f_linear_3d._[0].p[5]
assert not data storage bs:ward animation.bake.f_linear_3d._[0].p[6]
assert data storage bs:ward animation.bake.f_linear_3d._[0]
assert not data storage bs:ward animation.bake.f_linear_3d._[1]

data modify storage bs:ward animation.bake.f_step_1d set value {run:"function #bs.animation:callback/pos",basis:"step",duration:20,points:[[0d],[2.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_step_1d"}
assert data storage bs:ward animation.bake.f_step_1d._[{f:"1d/step"}]
assert result 7 run data get storage bs:ward animation.bake.f_step_1d._[0].f
assert data storage bs:ward animation.bake.f_step_1d._[0].p[0]
assert not data storage bs:ward animation.bake.f_step_1d._[0].p[1]
assert data storage bs:ward animation.bake.f_step_1d._[1]
assert not data storage bs:ward animation.bake.f_step_1d._[2]

data modify storage bs:ward animation.bake.f_step_2d set value {run:"function #bs.animation:callback/pos",basis:"step",duration:20,points:[[0d,1d],[2.5d,-0.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_step_2d"}
assert data storage bs:ward animation.bake.f_step_2d._[{f:"2d/step"}]
assert result 7 run data get storage bs:ward animation.bake.f_step_2d._[0].f
assert data storage bs:ward animation.bake.f_step_2d._[0].p[1]
assert not data storage bs:ward animation.bake.f_step_2d._[0].p[2]
assert data storage bs:ward animation.bake.f_step_2d._[1]
assert not data storage bs:ward animation.bake.f_step_2d._[2]

data modify storage bs:ward animation.bake.f_step_3d set value {run:"function #bs.animation:callback/pos",basis:"step",duration:20,points:[[0d,1d,0d],[2.5d,-0.5d,1.5d]]}
function #bs.animation:bake {uses:"bs:ward animation.bake.f_step_3d"}
assert data storage bs:ward animation.bake.f_step_3d._[{f:"3d/step"}]
assert result 7 run data get storage bs:ward animation.bake.f_step_3d._[0].f
assert data storage bs:ward animation.bake.f_step_3d._[0].p[2]
assert not data storage bs:ward animation.bake.f_step_3d._[0].p[3]
assert data storage bs:ward animation.bake.f_step_3d._[1]
assert not data storage bs:ward animation.bake.f_step_3d._[2]
