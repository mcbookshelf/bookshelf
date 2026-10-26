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

data modify storage bs.animation: stack append value {_:[{k:4,r:1,n:1,i:0,t:0.0f,d:100,p:[[0.0f,0.0f,0.0f,0.0f],[1.0f,2.0f,0.0f,4.0f],[3.0f,2.0f,1.0f,4.0f],[4.0f,0.0f,3.0f,0.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result -1..1 run compute default float bs.animation:eval/0 1000
assert result -1..1 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result -1..1 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 249..251 run compute default float bs.animation:eval/0 1000
assert result 499..501 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result 999..1001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 499..501 run compute default float bs.animation:eval/0 1000
assert result 999..1001 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result 1999..2001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 749..751 run compute default float bs.animation:eval/0 1000
assert result 1499..1501 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result 2999..3001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 999..1001 run compute default float bs.animation:eval/0 1000
assert result 1999..2001 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result 3999..4001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]

data modify storage bs.animation: stack append value {_:[{k:4,r:1,n:1,i:0,t:0.0f,d:100,p:[[1000.0f,-500.0f,250.0f,10.0f],[1002.0f,-498.0f,250.5f,12.0f],[1003.0f,-497.0f,251.5f,12.0f],[1004.0f,-496.0f,253.0f,10.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 999999..1000001 run compute default float bs.animation:eval/0 1000
assert result -500001..-499999 run compute default float bs.animation:eval/1 1000
assert result 249999..250001 run compute default float bs.animation:eval/2 1000
assert result 9999..10001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1000499..1000501 run compute default float bs.animation:eval/0 1000
assert result -499501..-499499 run compute default float bs.animation:eval/1 1000
assert result 250124..250126 run compute default float bs.animation:eval/2 1000
assert result 10499..10501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1000999..1001001 run compute default float bs.animation:eval/0 1000
assert result -499001..-498999 run compute default float bs.animation:eval/1 1000
assert result 250249..250251 run compute default float bs.animation:eval/2 1000
assert result 10999..11001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1001499..1001501 run compute default float bs.animation:eval/0 1000
assert result -498501..-498499 run compute default float bs.animation:eval/1 1000
assert result 250374..250376 run compute default float bs.animation:eval/2 1000
assert result 11499..11501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1001999..1002001 run compute default float bs.animation:eval/0 1000
assert result -498001..-497999 run compute default float bs.animation:eval/1 1000
assert result 250499..250501 run compute default float bs.animation:eval/2 1000
assert result 11999..12001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]
