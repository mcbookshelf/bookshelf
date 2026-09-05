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

data modify storage bs:ward animation.bake.smooth_1d set value { \
  basis: "smooth", \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.smooth_1d"}

# 7 segment(s), 4 coefficient(s) each
assert result 0 run data get storage bs:ward animation.bake.smooth_1d._[0].p[0]
assert result 2500 run data get storage bs:ward animation.bake.smooth_1d._[0].p[1]
assert result 875 run data get storage bs:ward animation.bake.smooth_1d._[0].p[2]
assert result -875 run data get storage bs:ward animation.bake.smooth_1d._[0].p[3]

assert result 2500 run data get storage bs:ward animation.bake.smooth_1d._[1].p[0]
assert result 1625 run data get storage bs:ward animation.bake.smooth_1d._[1].p[1]
assert result 1125 run data get storage bs:ward animation.bake.smooth_1d._[1].p[2]
assert result -2000 run data get storage bs:ward animation.bake.smooth_1d._[1].p[3]

assert result 3250 run data get storage bs:ward animation.bake.smooth_1d._[2].p[0]
assert result -2125 run data get storage bs:ward animation.bake.smooth_1d._[2].p[1]
assert result -11125 run data get storage bs:ward animation.bake.smooth_1d._[2].p[2]
assert result 8250 run data get storage bs:ward animation.bake.smooth_1d._[2].p[3]

assert result -1750 run data get storage bs:ward animation.bake.smooth_1d._[3].p[0]
assert result 375 run data get storage bs:ward animation.bake.smooth_1d._[3].p[1]
assert result 12375 run data get storage bs:ward animation.bake.smooth_1d._[3].p[2]
assert result -7000 run data get storage bs:ward animation.bake.smooth_1d._[3].p[3]

assert result 4000 run data get storage bs:ward animation.bake.smooth_1d._[4].p[0]
assert result 4125 run data get storage bs:ward animation.bake.smooth_1d._[4].p[1]
assert result -1375 run data get storage bs:ward animation.bake.smooth_1d._[4].p[2]
assert result -250 run data get storage bs:ward animation.bake.smooth_1d._[4].p[3]

assert result 6500 run data get storage bs:ward animation.bake.smooth_1d._[5].p[0]
assert result 625 run data get storage bs:ward animation.bake.smooth_1d._[5].p[1]
assert result -2250 run data get storage bs:ward animation.bake.smooth_1d._[5].p[2]
assert result 375 run data get storage bs:ward animation.bake.smooth_1d._[5].p[3]

assert result 5250 run data get storage bs:ward animation.bake.smooth_1d._[6].p[0]
assert result -2750 run data get storage bs:ward animation.bake.smooth_1d._[6].p[1]
assert result -3000 run data get storage bs:ward animation.bake.smooth_1d._[6].p[2]
assert result 1500 run data get storage bs:ward animation.bake.smooth_1d._[6].p[3]

# pin the segment count
assert data storage bs:ward animation.bake.smooth_1d._[6]
assert not data storage bs:ward animation.bake.smooth_1d._[7]

data modify storage bs:ward animation.bake.smooth_2d set value { \
  basis: "smooth", \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.smooth_2d"}

# 7 segment(s), 8 coefficient(s) each
assert result 0 run data get storage bs:ward animation.bake.smooth_2d._[0].p[0]
assert result 2500 run data get storage bs:ward animation.bake.smooth_2d._[0].p[1]
assert result 875 run data get storage bs:ward animation.bake.smooth_2d._[0].p[2]
assert result -875 run data get storage bs:ward animation.bake.smooth_2d._[0].p[3]
assert result 1000 run data get storage bs:ward animation.bake.smooth_2d._[0].p[4]
assert result -1500 run data get storage bs:ward animation.bake.smooth_2d._[0].p[5]
assert result -2000 run data get storage bs:ward animation.bake.smooth_2d._[0].p[6]
assert result 2000 run data get storage bs:ward animation.bake.smooth_2d._[0].p[7]

assert result 2500 run data get storage bs:ward animation.bake.smooth_2d._[1].p[0]
assert result 1625 run data get storage bs:ward animation.bake.smooth_2d._[1].p[1]
assert result 1125 run data get storage bs:ward animation.bake.smooth_2d._[1].p[2]
assert result -2000 run data get storage bs:ward animation.bake.smooth_2d._[1].p[3]
assert result -500 run data get storage bs:ward animation.bake.smooth_2d._[1].p[4]
assert result 500 run data get storage bs:ward animation.bake.smooth_2d._[1].p[5]
assert result 4500 run data get storage bs:ward animation.bake.smooth_2d._[1].p[6]
assert result -2500 run data get storage bs:ward animation.bake.smooth_2d._[1].p[7]

assert result 3250 run data get storage bs:ward animation.bake.smooth_2d._[2].p[0]
assert result -2125 run data get storage bs:ward animation.bake.smooth_2d._[2].p[1]
assert result -11125 run data get storage bs:ward animation.bake.smooth_2d._[2].p[2]
assert result 8250 run data get storage bs:ward animation.bake.smooth_2d._[2].p[3]
assert result 2000 run data get storage bs:ward animation.bake.smooth_2d._[2].p[4]
assert result 2000 run data get storage bs:ward animation.bake.smooth_2d._[2].p[5]
assert result 2500 run data get storage bs:ward animation.bake.smooth_2d._[2].p[6]
assert result -3000 run data get storage bs:ward animation.bake.smooth_2d._[2].p[7]

assert result -1750 run data get storage bs:ward animation.bake.smooth_2d._[3].p[0]
assert result 375 run data get storage bs:ward animation.bake.smooth_2d._[3].p[1]
assert result 12375 run data get storage bs:ward animation.bake.smooth_2d._[3].p[2]
assert result -7000 run data get storage bs:ward animation.bake.smooth_2d._[3].p[3]
assert result 3500 run data get storage bs:ward animation.bake.smooth_2d._[3].p[4]
assert result -2000 run data get storage bs:ward animation.bake.smooth_2d._[3].p[5]
assert result -10875 run data get storage bs:ward animation.bake.smooth_2d._[3].p[6]
assert result 7375 run data get storage bs:ward animation.bake.smooth_2d._[3].p[7]

assert result 4000 run data get storage bs:ward animation.bake.smooth_2d._[4].p[0]
assert result 4125 run data get storage bs:ward animation.bake.smooth_2d._[4].p[1]
assert result -1375 run data get storage bs:ward animation.bake.smooth_2d._[4].p[2]
assert result -250 run data get storage bs:ward animation.bake.smooth_2d._[4].p[3]
assert result -2000 run data get storage bs:ward animation.bake.smooth_2d._[4].p[4]
assert result -1625 run data get storage bs:ward animation.bake.smooth_2d._[4].p[5]
assert result 7000 run data get storage bs:ward animation.bake.smooth_2d._[4].p[6]
assert result -3125 run data get storage bs:ward animation.bake.smooth_2d._[4].p[7]

assert result 6500 run data get storage bs:ward animation.bake.smooth_2d._[5].p[0]
assert result 625 run data get storage bs:ward animation.bake.smooth_2d._[5].p[1]
assert result -2250 run data get storage bs:ward animation.bake.smooth_2d._[5].p[2]
assert result 375 run data get storage bs:ward animation.bake.smooth_2d._[5].p[3]
assert result 250 run data get storage bs:ward animation.bake.smooth_2d._[5].p[4]
assert result 3000 run data get storage bs:ward animation.bake.smooth_2d._[5].p[5]
assert result 6125 run data get storage bs:ward animation.bake.smooth_2d._[5].p[6]
assert result -5375 run data get storage bs:ward animation.bake.smooth_2d._[5].p[7]

assert result 5250 run data get storage bs:ward animation.bake.smooth_2d._[6].p[0]
assert result -2750 run data get storage bs:ward animation.bake.smooth_2d._[6].p[1]
assert result -3000 run data get storage bs:ward animation.bake.smooth_2d._[6].p[2]
assert result 1500 run data get storage bs:ward animation.bake.smooth_2d._[6].p[3]
assert result 4000 run data get storage bs:ward animation.bake.smooth_2d._[6].p[4]
assert result -875 run data get storage bs:ward animation.bake.smooth_2d._[6].p[5]
assert result -9250 run data get storage bs:ward animation.bake.smooth_2d._[6].p[6]
assert result 4625 run data get storage bs:ward animation.bake.smooth_2d._[6].p[7]

# pin the segment count
assert data storage bs:ward animation.bake.smooth_2d._[6]
assert not data storage bs:ward animation.bake.smooth_2d._[7]

data modify storage bs:ward animation.bake.smooth_3d set value { \
  basis: "smooth", \
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
function #bs.animation:bake {uses:"bs:ward animation.bake.smooth_3d"}

# 7 segment(s), 12 coefficient(s) each
assert result 0 run data get storage bs:ward animation.bake.smooth_3d._[0].p[0]
assert result 2500 run data get storage bs:ward animation.bake.smooth_3d._[0].p[1]
assert result 875 run data get storage bs:ward animation.bake.smooth_3d._[0].p[2]
assert result -875 run data get storage bs:ward animation.bake.smooth_3d._[0].p[3]
assert result 1000 run data get storage bs:ward animation.bake.smooth_3d._[0].p[4]
assert result -1500 run data get storage bs:ward animation.bake.smooth_3d._[0].p[5]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[0].p[6]
assert result 2000 run data get storage bs:ward animation.bake.smooth_3d._[0].p[7]
assert result 0 run data get storage bs:ward animation.bake.smooth_3d._[0].p[8]
assert result 1500 run data get storage bs:ward animation.bake.smooth_3d._[0].p[9]
assert result 2500 run data get storage bs:ward animation.bake.smooth_3d._[0].p[10]
assert result -2500 run data get storage bs:ward animation.bake.smooth_3d._[0].p[11]

assert result 2500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[0]
assert result 1625 run data get storage bs:ward animation.bake.smooth_3d._[1].p[1]
assert result 1125 run data get storage bs:ward animation.bake.smooth_3d._[1].p[2]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[1].p[3]
assert result -500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[4]
assert result 500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[5]
assert result 4500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[6]
assert result -2500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[7]
assert result 1500 run data get storage bs:ward animation.bake.smooth_3d._[1].p[8]
assert result -1000 run data get storage bs:ward animation.bake.smooth_3d._[1].p[9]
assert result -9250 run data get storage bs:ward animation.bake.smooth_3d._[1].p[10]
assert result 6750 run data get storage bs:ward animation.bake.smooth_3d._[1].p[11]

assert result 3250 run data get storage bs:ward animation.bake.smooth_3d._[2].p[0]
assert result -2125 run data get storage bs:ward animation.bake.smooth_3d._[2].p[1]
assert result -11125 run data get storage bs:ward animation.bake.smooth_3d._[2].p[2]
assert result 8250 run data get storage bs:ward animation.bake.smooth_3d._[2].p[3]
assert result 2000 run data get storage bs:ward animation.bake.smooth_3d._[2].p[4]
assert result 2000 run data get storage bs:ward animation.bake.smooth_3d._[2].p[5]
assert result 2500 run data get storage bs:ward animation.bake.smooth_3d._[2].p[6]
assert result -3000 run data get storage bs:ward animation.bake.smooth_3d._[2].p[7]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[2].p[8]
assert result 750 run data get storage bs:ward animation.bake.smooth_3d._[2].p[9]
assert result 12125 run data get storage bs:ward animation.bake.smooth_3d._[2].p[10]
assert result -7875 run data get storage bs:ward animation.bake.smooth_3d._[2].p[11]

assert result -1750 run data get storage bs:ward animation.bake.smooth_3d._[3].p[0]
assert result 375 run data get storage bs:ward animation.bake.smooth_3d._[3].p[1]
assert result 12375 run data get storage bs:ward animation.bake.smooth_3d._[3].p[2]
assert result -7000 run data get storage bs:ward animation.bake.smooth_3d._[3].p[3]
assert result 3500 run data get storage bs:ward animation.bake.smooth_3d._[3].p[4]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[3].p[5]
assert result -10875 run data get storage bs:ward animation.bake.smooth_3d._[3].p[6]
assert result 7375 run data get storage bs:ward animation.bake.smooth_3d._[3].p[7]
assert result 3000 run data get storage bs:ward animation.bake.smooth_3d._[3].p[8]
assert result 1375 run data get storage bs:ward animation.bake.smooth_3d._[3].p[9]
assert result -7500 run data get storage bs:ward animation.bake.smooth_3d._[3].p[10]
assert result 3875 run data get storage bs:ward animation.bake.smooth_3d._[3].p[11]

assert result 4000 run data get storage bs:ward animation.bake.smooth_3d._[4].p[0]
assert result 4125 run data get storage bs:ward animation.bake.smooth_3d._[4].p[1]
assert result -1375 run data get storage bs:ward animation.bake.smooth_3d._[4].p[2]
assert result -250 run data get storage bs:ward animation.bake.smooth_3d._[4].p[3]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[4].p[4]
assert result -1625 run data get storage bs:ward animation.bake.smooth_3d._[4].p[5]
assert result 7000 run data get storage bs:ward animation.bake.smooth_3d._[4].p[6]
assert result -3125 run data get storage bs:ward animation.bake.smooth_3d._[4].p[7]
assert result 750 run data get storage bs:ward animation.bake.smooth_3d._[4].p[8]
assert result -2000 run data get storage bs:ward animation.bake.smooth_3d._[4].p[9]
assert result -2125 run data get storage bs:ward animation.bake.smooth_3d._[4].p[10]
assert result 2375 run data get storage bs:ward animation.bake.smooth_3d._[4].p[11]

assert result 6500 run data get storage bs:ward animation.bake.smooth_3d._[5].p[0]
assert result 625 run data get storage bs:ward animation.bake.smooth_3d._[5].p[1]
assert result -2250 run data get storage bs:ward animation.bake.smooth_3d._[5].p[2]
assert result 375 run data get storage bs:ward animation.bake.smooth_3d._[5].p[3]
assert result 250 run data get storage bs:ward animation.bake.smooth_3d._[5].p[4]
assert result 3000 run data get storage bs:ward animation.bake.smooth_3d._[5].p[5]
assert result 6125 run data get storage bs:ward animation.bake.smooth_3d._[5].p[6]
assert result -5375 run data get storage bs:ward animation.bake.smooth_3d._[5].p[7]
assert result -1000 run data get storage bs:ward animation.bake.smooth_3d._[5].p[8]
assert result 875 run data get storage bs:ward animation.bake.smooth_3d._[5].p[9]
assert result 9875 run data get storage bs:ward animation.bake.smooth_3d._[5].p[10]
assert result -7250 run data get storage bs:ward animation.bake.smooth_3d._[5].p[11]

assert result 5250 run data get storage bs:ward animation.bake.smooth_3d._[6].p[0]
assert result -2750 run data get storage bs:ward animation.bake.smooth_3d._[6].p[1]
assert result -3000 run data get storage bs:ward animation.bake.smooth_3d._[6].p[2]
assert result 1500 run data get storage bs:ward animation.bake.smooth_3d._[6].p[3]
assert result 4000 run data get storage bs:ward animation.bake.smooth_3d._[6].p[4]
assert result -875 run data get storage bs:ward animation.bake.smooth_3d._[6].p[5]
assert result -9250 run data get storage bs:ward animation.bake.smooth_3d._[6].p[6]
assert result 4625 run data get storage bs:ward animation.bake.smooth_3d._[6].p[7]
assert result 2500 run data get storage bs:ward animation.bake.smooth_3d._[6].p[8]
assert result -1125 run data get storage bs:ward animation.bake.smooth_3d._[6].p[9]
assert result -9250 run data get storage bs:ward animation.bake.smooth_3d._[6].p[10]
assert result 4625 run data get storage bs:ward animation.bake.smooth_3d._[6].p[11]

# pin the segment count
assert data storage bs:ward animation.bake.smooth_3d._[6]
assert not data storage bs:ward animation.bake.smooth_3d._[7]
