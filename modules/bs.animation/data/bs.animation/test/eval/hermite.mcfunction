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

data modify storage bs.animation: stack append value {_:[{k:3,r:2,n:1,i:0,t:0.0f,d:100,p:[[0.0f,0.0f,0.0f,0.0f],[3.0f,1.0f,0.0f,2.0f],[2.0f,2.0f,1.0f,1.0f],[0.0f,1.0f,3.0f,-2.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result -1..1 run compute default float bs.animation:eval/0 1000
assert result -1..1 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result -1..1 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 733..735 run compute default float bs.animation:eval/0 1000
assert result 405..407 run compute default float bs.animation:eval/1 1000
assert result 14..16 run compute default float bs.animation:eval/2 1000
assert result 530..532 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1374..1376 run compute default float bs.animation:eval/0 1000
assert result 999..1001 run compute default float bs.animation:eval/1 1000
assert result 124..126 run compute default float bs.animation:eval/2 1000
assert result 999..1001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1827..1829 run compute default float bs.animation:eval/0 1000
assert result 1592..1594 run compute default float bs.animation:eval/1 1000
assert result 420..422 run compute default float bs.animation:eval/2 1000
assert result 1217..1219 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1999..2001 run compute default float bs.animation:eval/0 1000
assert result 1999..2001 run compute default float bs.animation:eval/1 1000
assert result 999..1001 run compute default float bs.animation:eval/2 1000
assert result 999..1001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]

data modify storage bs.animation: stack append value {_:[{k:3,r:2,n:1,i:0,t:0.0f,d:100,p:[[1000.0f,-500.0f,250.0f,10.0f],[3.0f,-2.0f,1.0f,2.0f],[1002.0f,-502.0f,251.0f,11.0f],[3.0f,1.0f,0.0f,-2.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 999999..1000001 run compute default float bs.animation:eval/0 1000
assert result -500001..-499999 run compute default float bs.animation:eval/1 1000
assert result 249999..250001 run compute default float bs.animation:eval/2 1000
assert result 9999..10001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1000592..1000594 run compute default float bs.animation:eval/0 1000
assert result -500642..-500640 run compute default float bs.animation:eval/1 1000
assert result 250295..250297 run compute default float bs.animation:eval/2 1000
assert result 10530..10532 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1000999..1001001 run compute default float bs.animation:eval/0 1000
assert result -501376..-501374 run compute default float bs.animation:eval/1 1000
assert result 250624..250626 run compute default float bs.animation:eval/2 1000
assert result 10999..11001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1001405..1001407 run compute default float bs.animation:eval/0 1000
assert result -501923..-501921 run compute default float bs.animation:eval/1 1000
assert result 250889..250891 run compute default float bs.animation:eval/2 1000
assert result 11217..11219 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1001999..1002001 run compute default float bs.animation:eval/0 1000
assert result -502001..-501999 run compute default float bs.animation:eval/1 1000
assert result 250999..251001 run compute default float bs.animation:eval/2 1000
assert result 10999..11001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]
