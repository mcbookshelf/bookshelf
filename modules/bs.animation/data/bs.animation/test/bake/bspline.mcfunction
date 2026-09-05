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

data modify storage bs:ward animation.bake.bspline_1d set value { \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.bspline_1d"}

# 5 segment(s), 4 coefficient(s) each
assert result 2208 run data get storage bs:ward animation.bake.bspline_1d._[0].p[0]
assert result 1625 run data get storage bs:ward animation.bake.bspline_1d._[0].p[1]
assert result -875 run data get storage bs:ward animation.bake.bspline_1d._[0].p[2]
assert result -667 run data get storage bs:ward animation.bake.bspline_1d._[0].p[3]

assert result 2292 run data get storage bs:ward animation.bake.bspline_1d._[1].p[0]
assert result -2125 run data get storage bs:ward animation.bake.bspline_1d._[1].p[1]
assert result -2875 run data get storage bs:ward animation.bake.bspline_1d._[1].p[2]
assert result 2750 run data get storage bs:ward animation.bake.bspline_1d._[1].p[3]

assert result 42 run data get storage bs:ward animation.bake.bspline_1d._[2].p[0]
assert result 375 run data get storage bs:ward animation.bake.bspline_1d._[2].p[1]
assert result 5375 run data get storage bs:ward animation.bake.bspline_1d._[2].p[2]
assert result -2334 run data get storage bs:ward animation.bake.bspline_1d._[2].p[3]

assert result 3458 run data get storage bs:ward animation.bake.bspline_1d._[3].p[0]
assert result 4125 run data get storage bs:ward animation.bake.bspline_1d._[3].p[1]
assert result -1625 run data get storage bs:ward animation.bake.bspline_1d._[3].p[2]
assert result -84 run data get storage bs:ward animation.bake.bspline_1d._[3].p[3]

assert result 5875 run data get storage bs:ward animation.bake.bspline_1d._[4].p[0]
assert result 625 run data get storage bs:ward animation.bake.bspline_1d._[4].p[1]
assert result -1875 run data get storage bs:ward animation.bake.bspline_1d._[4].p[2]
assert result 125 run data get storage bs:ward animation.bake.bspline_1d._[4].p[3]

# pin the segment count
assert data storage bs:ward animation.bake.bspline_1d._[4]
assert not data storage bs:ward animation.bake.bspline_1d._[5]

data modify storage bs:ward animation.bake.bspline_2d set value { \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.bspline_2d"}

# 5 segment(s), 8 coefficient(s) each
assert result 2208 run data get storage bs:ward animation.bake.bspline_2d._[0].p[0]
assert result 1625 run data get storage bs:ward animation.bake.bspline_2d._[0].p[1]
assert result -875 run data get storage bs:ward animation.bake.bspline_2d._[0].p[2]
assert result -667 run data get storage bs:ward animation.bake.bspline_2d._[0].p[3]
assert result 167 run data get storage bs:ward animation.bake.bspline_2d._[0].p[4]
assert result 500 run data get storage bs:ward animation.bake.bspline_2d._[0].p[5]
assert result 2000 run data get storage bs:ward animation.bake.bspline_2d._[0].p[6]
assert result -834 run data get storage bs:ward animation.bake.bspline_2d._[0].p[7]

assert result 2292 run data get storage bs:ward animation.bake.bspline_2d._[1].p[0]
assert result -2125 run data get storage bs:ward animation.bake.bspline_2d._[1].p[1]
assert result -2875 run data get storage bs:ward animation.bake.bspline_2d._[1].p[2]
assert result 2750 run data get storage bs:ward animation.bake.bspline_2d._[1].p[3]
assert result 1833 run data get storage bs:ward animation.bake.bspline_2d._[1].p[4]
assert result 2000 run data get storage bs:ward animation.bake.bspline_2d._[1].p[5]
assert result -500 run data get storage bs:ward animation.bake.bspline_2d._[1].p[6]
assert result -1000 run data get storage bs:ward animation.bake.bspline_2d._[1].p[7]

assert result 42 run data get storage bs:ward animation.bake.bspline_2d._[2].p[0]
assert result 375 run data get storage bs:ward animation.bake.bspline_2d._[2].p[1]
assert result 5375 run data get storage bs:ward animation.bake.bspline_2d._[2].p[2]
assert result -2334 run data get storage bs:ward animation.bake.bspline_2d._[2].p[3]
assert result 2333 run data get storage bs:ward animation.bake.bspline_2d._[2].p[4]
assert result -2000 run data get storage bs:ward animation.bake.bspline_2d._[2].p[5]
assert result -3500 run data get storage bs:ward animation.bake.bspline_2d._[2].p[6]
assert result 2458 run data get storage bs:ward animation.bake.bspline_2d._[2].p[7]

assert result 3458 run data get storage bs:ward animation.bake.bspline_2d._[3].p[0]
assert result 4125 run data get storage bs:ward animation.bake.bspline_2d._[3].p[1]
assert result -1625 run data get storage bs:ward animation.bake.bspline_2d._[3].p[2]
assert result -84 run data get storage bs:ward animation.bake.bspline_2d._[3].p[3]
assert result -708 run data get storage bs:ward animation.bake.bspline_2d._[3].p[4]
assert result -1625 run data get storage bs:ward animation.bake.bspline_2d._[3].p[5]
assert result 3875 run data get storage bs:ward animation.bake.bspline_2d._[3].p[6]
assert result -1042 run data get storage bs:ward animation.bake.bspline_2d._[3].p[7]

assert result 5875 run data get storage bs:ward animation.bake.bspline_2d._[4].p[0]
assert result 625 run data get storage bs:ward animation.bake.bspline_2d._[4].p[1]
assert result -1875 run data get storage bs:ward animation.bake.bspline_2d._[4].p[2]
assert result 125 run data get storage bs:ward animation.bake.bspline_2d._[4].p[3]
assert result 500 run data get storage bs:ward animation.bake.bspline_2d._[4].p[4]
assert result 3000 run data get storage bs:ward animation.bake.bspline_2d._[4].p[5]
assert result 750 run data get storage bs:ward animation.bake.bspline_2d._[4].p[6]
assert result -1792 run data get storage bs:ward animation.bake.bspline_2d._[4].p[7]

# pin the segment count
assert data storage bs:ward animation.bake.bspline_2d._[4]
assert not data storage bs:ward animation.bake.bspline_2d._[5]

data modify storage bs:ward animation.bake.bspline_3d set value { \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.bspline_3d"}

# 5 segment(s), 12 coefficient(s) each
assert result 2208 run data get storage bs:ward animation.bake.bspline_3d._[0].p[0]
assert result 1625 run data get storage bs:ward animation.bake.bspline_3d._[0].p[1]
assert result -875 run data get storage bs:ward animation.bake.bspline_3d._[0].p[2]
assert result -667 run data get storage bs:ward animation.bake.bspline_3d._[0].p[3]
assert result 167 run data get storage bs:ward animation.bake.bspline_3d._[0].p[4]
assert result 500 run data get storage bs:ward animation.bake.bspline_3d._[0].p[5]
assert result 2000 run data get storage bs:ward animation.bake.bspline_3d._[0].p[6]
assert result -834 run data get storage bs:ward animation.bake.bspline_3d._[0].p[7]
assert result 667 run data get storage bs:ward animation.bake.bspline_3d._[0].p[8]
assert result -1000 run data get storage bs:ward animation.bake.bspline_3d._[0].p[9]
assert result -2500 run data get storage bs:ward animation.bake.bspline_3d._[0].p[10]
assert result 2250 run data get storage bs:ward animation.bake.bspline_3d._[0].p[11]

assert result 2292 run data get storage bs:ward animation.bake.bspline_3d._[1].p[0]
assert result -2125 run data get storage bs:ward animation.bake.bspline_3d._[1].p[1]
assert result -2875 run data get storage bs:ward animation.bake.bspline_3d._[1].p[2]
assert result 2750 run data get storage bs:ward animation.bake.bspline_3d._[1].p[3]
assert result 1833 run data get storage bs:ward animation.bake.bspline_3d._[1].p[4]
assert result 2000 run data get storage bs:ward animation.bake.bspline_3d._[1].p[5]
assert result -500 run data get storage bs:ward animation.bake.bspline_3d._[1].p[6]
assert result -1000 run data get storage bs:ward animation.bake.bspline_3d._[1].p[7]
assert result -583 run data get storage bs:ward animation.bake.bspline_3d._[1].p[8]
assert result 750 run data get storage bs:ward animation.bake.bspline_3d._[1].p[9]
assert result 4250 run data get storage bs:ward animation.bake.bspline_3d._[1].p[10]
assert result -2625 run data get storage bs:ward animation.bake.bspline_3d._[1].p[11]

assert result 42 run data get storage bs:ward animation.bake.bspline_3d._[2].p[0]
assert result 375 run data get storage bs:ward animation.bake.bspline_3d._[2].p[1]
assert result 5375 run data get storage bs:ward animation.bake.bspline_3d._[2].p[2]
assert result -2334 run data get storage bs:ward animation.bake.bspline_3d._[2].p[3]
assert result 2333 run data get storage bs:ward animation.bake.bspline_3d._[2].p[4]
assert result -2000 run data get storage bs:ward animation.bake.bspline_3d._[2].p[5]
assert result -3500 run data get storage bs:ward animation.bake.bspline_3d._[2].p[6]
assert result 2458 run data get storage bs:ward animation.bake.bspline_3d._[2].p[7]
assert result 1792 run data get storage bs:ward animation.bake.bspline_3d._[2].p[8]
assert result 1375 run data get storage bs:ward animation.bake.bspline_3d._[2].p[9]
assert result -3625 run data get storage bs:ward animation.bake.bspline_3d._[2].p[10]
assert result 1291 run data get storage bs:ward animation.bake.bspline_3d._[2].p[11]

assert result 3458 run data get storage bs:ward animation.bake.bspline_3d._[3].p[0]
assert result 4125 run data get storage bs:ward animation.bake.bspline_3d._[3].p[1]
assert result -1625 run data get storage bs:ward animation.bake.bspline_3d._[3].p[2]
assert result -84 run data get storage bs:ward animation.bake.bspline_3d._[3].p[3]
assert result -708 run data get storage bs:ward animation.bake.bspline_3d._[3].p[4]
assert result -1625 run data get storage bs:ward animation.bake.bspline_3d._[3].p[5]
assert result 3875 run data get storage bs:ward animation.bake.bspline_3d._[3].p[6]
assert result -1042 run data get storage bs:ward animation.bake.bspline_3d._[3].p[7]
assert result 833 run data get storage bs:ward animation.bake.bspline_3d._[3].p[8]
assert result -2000 run data get storage bs:ward animation.bake.bspline_3d._[3].p[9]
assert result 250 run data get storage bs:ward animation.bake.bspline_3d._[3].p[10]
assert result 791 run data get storage bs:ward animation.bake.bspline_3d._[3].p[11]

assert result 5875 run data get storage bs:ward animation.bake.bspline_3d._[4].p[0]
assert result 625 run data get storage bs:ward animation.bake.bspline_3d._[4].p[1]
assert result -1875 run data get storage bs:ward animation.bake.bspline_3d._[4].p[2]
assert result 125 run data get storage bs:ward animation.bake.bspline_3d._[4].p[3]
assert result 500 run data get storage bs:ward animation.bake.bspline_3d._[4].p[4]
assert result 3000 run data get storage bs:ward animation.bake.bspline_3d._[4].p[5]
assert result 750 run data get storage bs:ward animation.bake.bspline_3d._[4].p[6]
assert result -1792 run data get storage bs:ward animation.bake.bspline_3d._[4].p[7]
assert result -125 run data get storage bs:ward animation.bake.bspline_3d._[4].p[8]
assert result 875 run data get storage bs:ward animation.bake.bspline_3d._[4].p[9]
assert result 2625 run data get storage bs:ward animation.bake.bspline_3d._[4].p[10]
assert result -2417 run data get storage bs:ward animation.bake.bspline_3d._[4].p[11]

# pin the segment count
assert data storage bs:ward animation.bake.bspline_3d._[4]
assert not data storage bs:ward animation.bake.bspline_3d._[5]
