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

# --- duration list
data modify storage bs.animation: stack append value {_:[{k:0,r:3,n:3,i:0,t:0.0f,s:1.0f,v:1,w:100,d:[10,20,15],d0:[10,20,15],p:[[0.0f,0.0f,0.0f,0.0f],[1.0f,2.0f,0.0f,4.0f],[3.0f,2.0f,1.0f,4.0f],[4.0f,0.0f,3.0f,0.0f],[5.0f,3.0f,3.0f,2.0f],[7.0f,3.0f,5.0f,2.0f],[8.0f,0.0f,6.0f,0.0f],[9.0f,1.0f,6.0f,1.0f],[11.0f,1.0f,8.0f,1.0f],[12.0f,0.0f,9.0f,0.0f],[99.0f,99.0f,99.0f,99.0f],[98.0f,98.0f,98.0f,98.0f]],p0:[[0.0f,0.0f,0.0f,0.0f],[1.0f,2.0f,0.0f,4.0f],[3.0f,2.0f,1.0f,4.0f],[4.0f,0.0f,3.0f,0.0f],[5.0f,3.0f,3.0f,2.0f],[7.0f,3.0f,5.0f,2.0f],[8.0f,0.0f,6.0f,0.0f],[9.0f,1.0f,6.0f,1.0f],[11.0f,1.0f,8.0f,1.0f],[12.0f,0.0f,9.0f,0.0f],[99.0f,99.0f,99.0f,99.0f],[98.0f,98.0f,98.0f,98.0f]]}]}

# half of the first segment
data modify storage bs.animation: stack[-1]._[0].s set value 5.0f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 499..501 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].i
assert result 10 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# stack step overrides s
data modify storage bs.animation: stack[-1]._[0].s set value 5.0f
data modify storage bs.animation: stack[-1].step set value 2.5f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
data remove storage bs.animation: stack[-1].step
assert result 749..751 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].i
assert result 10 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# to the boundary: rotates, t carried as 0
data modify storage bs.animation: stack[-1]._[0].s set value 2.5f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result -1..1 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 1 run data get storage bs.animation: stack[-1]._[0].i
assert result 20 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 4000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# small negative: back into the first segment
data modify storage bs.animation: stack[-1]._[0].s set value -5.0f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 499..501 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].i
assert result 10 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# big positive without loop: halts at the end
data modify storage bs.animation: stack[-1]._[0].s set value 90f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 999..1001 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 2 run data get storage bs.animation: stack[-1]._[0].i
assert result 15 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 8000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000
assert not data storage bs.animation: stack[-1]._[0].w

# big negative without loop: halts at the start
data modify storage bs.animation: stack[-1]._[0].s set value -90f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result -1..1 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].i
assert result 10 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

data modify storage bs.animation: stack[-1]._[0].l set value 1b
data modify storage bs.animation: stack[-1]._[0].w set value 100

# loop, big positive: wraps forward
data modify storage bs.animation: stack[-1]._[0].s set value 67.5f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 624..626 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 1 run data get storage bs.animation: stack[-1]._[0].i
assert result 20 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 4000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# loop, big negative: wraps backward
data modify storage bs.animation: stack[-1]._[0].s set value -67.5f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result -1..1 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].i
assert result 10 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# loop, negative from the start: rotates n-1 times, lands in the last used segment, tail skipped
data modify storage bs.animation: stack[-1]._[0].s set value -3.75f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 749..751 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 2 run data get storage bs.animation: stack[-1]._[0].i
assert result 15 run data get storage bs.animation: stack[-1]._[0].d[0]
assert result 8000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# --- same track on a total duration, d / n per segment
data modify storage bs.animation: stack[-1]._[0].d set value 45
data modify storage bs.animation: stack[-1]._[0].d0 set value 45
data modify storage bs.animation: stack[-1]._[0].p set from storage bs.animation: stack[-1]._[0].p0
data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
data modify storage bs.animation: stack[-1]._[0].i set value 0
data remove storage bs.animation: stack[-1]._[0].l

# crossing one boundary
data modify storage bs.animation: stack[-1]._[0].s set value 18.75f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 249..251 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 1 run data get storage bs.animation: stack[-1]._[0].i
assert result 4000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

# big positive without loop: halts at the end
data modify storage bs.animation: stack[-1]._[0].s set value 90f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 999..1001 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 2 run data get storage bs.animation: stack[-1]._[0].i
assert result 8000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000
assert not data storage bs.animation: stack[-1]._[0].w

data modify storage bs.animation: stack[-1]._[0].l set value 1b
data modify storage bs.animation: stack[-1]._[0].w set value 100

# loop, big negative: wraps backward
data modify storage bs.animation: stack[-1]._[0].s set value -67.5f
function bs.animation:utils/advance with storage bs.animation: stack[-1]._[0]
assert result 499..501 run data get storage bs.animation: stack[-1]._[0].t 1000
assert result 1 run data get storage bs.animation: stack[-1]._[0].i
assert result 4000 run data get storage bs.animation: stack[-1]._[0].p[0][0] 1000
assert result 0 run data get storage bs.animation: stack[-1]._[0].p[0][1] 1000

data remove storage bs.animation: stack[-1]
