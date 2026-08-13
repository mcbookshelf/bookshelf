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

# Global duration: split evenly across segments.
# Every total here divides EXACTLY by the segment count, so these
# asserts do not depend on remainder-distribution behaviour.

data modify storage bs:ward animation.bake.dur_global_bezier_1d set value { \
  basis: "bezier", \
  duration: 100, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bezier_1d"}

assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_1d._[0].d
assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_1d._[1].d

assert data storage bs:ward animation.bake.dur_global_bezier_1d._[1]
assert not data storage bs:ward animation.bake.dur_global_bezier_1d._[2]

data modify storage bs:ward animation.bake.dur_global_bezier_2d set value { \
  basis: "bezier", \
  duration: 100, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bezier_2d"}

assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_2d._[0].d
assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_2d._[1].d

assert data storage bs:ward animation.bake.dur_global_bezier_2d._[1]
assert not data storage bs:ward animation.bake.dur_global_bezier_2d._[2]

data modify storage bs:ward animation.bake.dur_global_bezier_3d set value { \
  basis: "bezier", \
  duration: 100, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bezier_3d"}

assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_3d._[0].d
assert result 50 run data get storage bs:ward animation.bake.dur_global_bezier_3d._[1].d

assert data storage bs:ward animation.bake.dur_global_bezier_3d._[1]
assert not data storage bs:ward animation.bake.dur_global_bezier_3d._[2]

data modify storage bs:ward animation.bake.dur_global_bspline_1d set value { \
  basis: "bspline", \
  duration: 100, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bspline_1d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_1d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_1d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_1d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_1d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_1d._[4].d

assert data storage bs:ward animation.bake.dur_global_bspline_1d._[4]
assert not data storage bs:ward animation.bake.dur_global_bspline_1d._[5]

data modify storage bs:ward animation.bake.dur_global_bspline_2d set value { \
  basis: "bspline", \
  duration: 100, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bspline_2d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_2d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_2d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_2d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_2d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_2d._[4].d

assert data storage bs:ward animation.bake.dur_global_bspline_2d._[4]
assert not data storage bs:ward animation.bake.dur_global_bspline_2d._[5]

data modify storage bs:ward animation.bake.dur_global_bspline_3d set value { \
  basis: "bspline", \
  duration: 100, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_bspline_3d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_3d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_3d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_3d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_3d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_bspline_3d._[4].d

assert data storage bs:ward animation.bake.dur_global_bspline_3d._[4]
assert not data storage bs:ward animation.bake.dur_global_bspline_3d._[5]

data modify storage bs:ward animation.bake.dur_global_catmull_rom_1d set value { \
  basis: "catmull_rom", \
  duration: 200, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_catmull_rom_1d"}

assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_1d._[0].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_1d._[1].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_1d._[2].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_1d._[3].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_1d._[4].d

assert data storage bs:ward animation.bake.dur_global_catmull_rom_1d._[4]
assert not data storage bs:ward animation.bake.dur_global_catmull_rom_1d._[5]

data modify storage bs:ward animation.bake.dur_global_catmull_rom_2d set value { \
  basis: "catmull_rom", \
  duration: 200, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_catmull_rom_2d"}

assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_2d._[0].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_2d._[1].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_2d._[2].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_2d._[3].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_2d._[4].d

assert data storage bs:ward animation.bake.dur_global_catmull_rom_2d._[4]
assert not data storage bs:ward animation.bake.dur_global_catmull_rom_2d._[5]

data modify storage bs:ward animation.bake.dur_global_catmull_rom_3d set value { \
  basis: "catmull_rom", \
  duration: 200, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_catmull_rom_3d"}

assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_3d._[0].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_3d._[1].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_3d._[2].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_3d._[3].d
assert result 40 run data get storage bs:ward animation.bake.dur_global_catmull_rom_3d._[4].d

assert data storage bs:ward animation.bake.dur_global_catmull_rom_3d._[4]
assert not data storage bs:ward animation.bake.dur_global_catmull_rom_3d._[5]

data modify storage bs:ward animation.bake.dur_global_hermite_1d set value { \
  basis: "hermite", \
  duration: 99, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_hermite_1d"}

assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_1d._[0].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_1d._[1].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_1d._[2].d

assert data storage bs:ward animation.bake.dur_global_hermite_1d._[2]
assert not data storage bs:ward animation.bake.dur_global_hermite_1d._[3]

data modify storage bs:ward animation.bake.dur_global_hermite_2d set value { \
  basis: "hermite", \
  duration: 99, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_hermite_2d"}

assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_2d._[0].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_2d._[1].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_2d._[2].d

assert data storage bs:ward animation.bake.dur_global_hermite_2d._[2]
assert not data storage bs:ward animation.bake.dur_global_hermite_2d._[3]

data modify storage bs:ward animation.bake.dur_global_hermite_3d set value { \
  basis: "hermite", \
  duration: 99, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_hermite_3d"}

assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_3d._[0].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_3d._[1].d
assert result 33 run data get storage bs:ward animation.bake.dur_global_hermite_3d._[2].d

assert data storage bs:ward animation.bake.dur_global_hermite_3d._[2]
assert not data storage bs:ward animation.bake.dur_global_hermite_3d._[3]

data modify storage bs:ward animation.bake.dur_global_linear_1d set value { \
  basis: "linear", \
  duration: 140, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_linear_1d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[4].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[5].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_1d._[6].d

assert data storage bs:ward animation.bake.dur_global_linear_1d._[6]
assert not data storage bs:ward animation.bake.dur_global_linear_1d._[7]

data modify storage bs:ward animation.bake.dur_global_linear_2d set value { \
  basis: "linear", \
  duration: 140, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_linear_2d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[4].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[5].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_2d._[6].d

assert data storage bs:ward animation.bake.dur_global_linear_2d._[6]
assert not data storage bs:ward animation.bake.dur_global_linear_2d._[7]

data modify storage bs:ward animation.bake.dur_global_linear_3d set value { \
  basis: "linear", \
  duration: 140, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_linear_3d"}

assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[0].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[1].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[2].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[3].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[4].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[5].d
assert result 20 run data get storage bs:ward animation.bake.dur_global_linear_3d._[6].d

assert data storage bs:ward animation.bake.dur_global_linear_3d._[6]
assert not data storage bs:ward animation.bake.dur_global_linear_3d._[7]

data modify storage bs:ward animation.bake.dur_global_smooth_1d set value { \
  basis: "smooth", \
  duration: 210, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_smooth_1d"}

assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[0].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[1].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[2].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[3].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[4].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[5].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_1d._[6].d

assert data storage bs:ward animation.bake.dur_global_smooth_1d._[6]
assert not data storage bs:ward animation.bake.dur_global_smooth_1d._[7]

data modify storage bs:ward animation.bake.dur_global_smooth_2d set value { \
  basis: "smooth", \
  duration: 210, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_smooth_2d"}

assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[0].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[1].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[2].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[3].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[4].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[5].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_2d._[6].d

assert data storage bs:ward animation.bake.dur_global_smooth_2d._[6]
assert not data storage bs:ward animation.bake.dur_global_smooth_2d._[7]

data modify storage bs:ward animation.bake.dur_global_smooth_3d set value { \
  basis: "smooth", \
  duration: 210, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_smooth_3d"}

assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[0].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[1].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[2].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[3].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[4].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[5].d
assert result 30 run data get storage bs:ward animation.bake.dur_global_smooth_3d._[6].d

assert data storage bs:ward animation.bake.dur_global_smooth_3d._[6]
assert not data storage bs:ward animation.bake.dur_global_smooth_3d._[7]

data modify storage bs:ward animation.bake.dur_global_step_1d set value { \
  basis: "step", \
  duration: 80, \
  points: [ \
    [0d], \
    [2.5d], \
    [3.25d], \
    [-1.75d], \
    [4d], \
    [6.5d], \
    [5.25d], \
    [1d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_step_1d"}

assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[0].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[1].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[2].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[3].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[4].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[5].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[6].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_1d._[7].d

assert data storage bs:ward animation.bake.dur_global_step_1d._[7]
assert not data storage bs:ward animation.bake.dur_global_step_1d._[8]

data modify storage bs:ward animation.bake.dur_global_step_2d set value { \
  basis: "step", \
  duration: 80, \
  points: [ \
    [0d,1d], \
    [2.5d,-0.5d], \
    [3.25d,2d], \
    [-1.75d,3.5d], \
    [4d,-2d], \
    [6.5d,0.25d], \
    [5.25d,4d], \
    [1d,-1.5d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_step_2d"}

assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[0].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[1].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[2].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[3].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[4].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[5].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[6].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_2d._[7].d

assert data storage bs:ward animation.bake.dur_global_step_2d._[7]
assert not data storage bs:ward animation.bake.dur_global_step_2d._[8]

data modify storage bs:ward animation.bake.dur_global_step_3d set value { \
  basis: "step", \
  duration: 80, \
  points: [ \
    [0d,1d,0d], \
    [2.5d,-0.5d,1.5d], \
    [3.25d,2d,-2d], \
    [-1.75d,3.5d,3d], \
    [4d,-2d,0.75d], \
    [6.5d,0.25d,-1d], \
    [5.25d,4d,2.5d], \
    [1d,-1.5d,-3.25d], \
  ], \
}
function #bs.animation:bake {uses:"bs:ward animation.bake.dur_global_step_3d"}

assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[0].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[1].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[2].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[3].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[4].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[5].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[6].d
assert result 10 run data get storage bs:ward animation.bake.dur_global_step_3d._[7].d

assert data storage bs:ward animation.bake.dur_global_step_3d._[7]
assert not data storage bs:ward animation.bake.dur_global_step_3d._[8]
