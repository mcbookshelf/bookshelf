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

data modify storage bs.animation: stack append value {_:[{k:2,r:1,n:1,i:0,t:0.0f,d:100,p:[[0.0f,0.0f,0.0f,0.0f],[1.0f,2.0f,0.0f,4.0f],[3.0f,2.0f,1.0f,4.0f],[4.0f,0.0f,3.0f,0.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 999..1001 run compute default float bs.animation:eval/0 1000
assert result 1999..2001 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result 3999..4001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1452..1454 run compute default float bs.animation:eval/0 1000
assert result 2186..2188 run compute default float bs.animation:eval/1 1000
assert result 155..157 run compute default float bs.animation:eval/2 1000
assert result 4374..4376 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1999..2001 run compute default float bs.animation:eval/0 1000
assert result 2249..2251 run compute default float bs.animation:eval/1 1000
assert result 374..376 run compute default float bs.animation:eval/2 1000
assert result 4499..4501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 2545..2547 run compute default float bs.animation:eval/0 1000
assert result 2186..2188 run compute default float bs.animation:eval/1 1000
assert result 655..657 run compute default float bs.animation:eval/2 1000
assert result 4374..4376 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 2999..3001 run compute default float bs.animation:eval/0 1000
assert result 1999..2001 run compute default float bs.animation:eval/1 1000
assert result 999..1001 run compute default float bs.animation:eval/2 1000
assert result 3999..4001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]

data modify storage bs.animation: stack append value {_:[{k:2,r:1,n:1,i:0,t:0.0f,d:100,p:[[1000.0f,-500.0f,250.0f,10.0f],[1001.0f,-498.0f,250.0f,14.0f],[1003.0f,-498.0f,251.0f,14.0f],[1004.0f,-500.0f,253.0f,10.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 1000999..1001001 run compute default float bs.animation:eval/0 1000
assert result -498001..-497999 run compute default float bs.animation:eval/1 1000
assert result 249999..250001 run compute default float bs.animation:eval/2 1000
assert result 13999..14001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1001452..1001454 run compute default float bs.animation:eval/0 1000
assert result -497814..-497812 run compute default float bs.animation:eval/1 1000
assert result 250155..250157 run compute default float bs.animation:eval/2 1000
assert result 14374..14376 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1001999..1002001 run compute default float bs.animation:eval/0 1000
assert result -497751..-497749 run compute default float bs.animation:eval/1 1000
assert result 250374..250376 run compute default float bs.animation:eval/2 1000
assert result 14499..14501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1002545..1002547 run compute default float bs.animation:eval/0 1000
assert result -497814..-497812 run compute default float bs.animation:eval/1 1000
assert result 250655..250657 run compute default float bs.animation:eval/2 1000
assert result 14374..14376 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1002999..1003001 run compute default float bs.animation:eval/0 1000
assert result -498001..-497999 run compute default float bs.animation:eval/1 1000
assert result 250999..251001 run compute default float bs.animation:eval/2 1000
assert result 13999..14001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]
