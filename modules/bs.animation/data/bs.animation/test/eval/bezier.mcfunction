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

data modify storage bs.animation: stack append value {_:[{k:0,r:3,n:1,i:0,t:0.0f,d:100,p:[[0.0f,0.0f,0.0f,0.0f],[1.0f,2.0f,0.0f,4.0f],[3.0f,2.0f,1.0f,4.0f],[4.0f,0.0f,3.0f,0.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result -1..1 run compute default float bs.animation:eval/0 1000
assert result -1..1 run compute default float bs.animation:eval/1 1000
assert result -1..1 run compute default float bs.animation:eval/2 1000
assert result -1..1 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 905..907 run compute default float bs.animation:eval/0 1000
assert result 1124..1126 run compute default float bs.animation:eval/1 1000
assert result 186..188 run compute default float bs.animation:eval/2 1000
assert result 2249..2251 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1999..2001 run compute default float bs.animation:eval/0 1000
assert result 1499..1501 run compute default float bs.animation:eval/1 1000
assert result 749..751 run compute default float bs.animation:eval/2 1000
assert result 2999..3001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 3092..3094 run compute default float bs.animation:eval/0 1000
assert result 1124..1126 run compute default float bs.animation:eval/1 1000
assert result 1686..1688 run compute default float bs.animation:eval/2 1000
assert result 2249..2251 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 3999..4001 run compute default float bs.animation:eval/0 1000
assert result -1..1 run compute default float bs.animation:eval/1 1000
assert result 2999..3001 run compute default float bs.animation:eval/2 1000
assert result -1..1 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]

data modify storage bs.animation: stack append value {_:[{k:0,r:3,n:1,i:0,t:0.0f,d:100,p:[[1000.0f,-500.0f,250.0f,10.0f],[1002.0f,-498.0f,250.5f,12.0f],[1003.0f,-497.0f,251.5f,12.0f],[1004.0f,-496.0f,253.0f,10.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 999999..1000001 run compute default float bs.animation:eval/0 1000
assert result -500001..-499999 run compute default float bs.animation:eval/1 1000
assert result 249999..250001 run compute default float bs.animation:eval/2 1000
assert result 9999..10001 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1001327..1001329 run compute default float bs.animation:eval/0 1000
assert result -498673..-498671 run compute default float bs.animation:eval/1 1000
assert result 250467..250469 run compute default float bs.animation:eval/2 1000
assert result 11124..11126 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1002374..1002376 run compute default float bs.animation:eval/0 1000
assert result -497626..-497624 run compute default float bs.animation:eval/1 1000
assert result 251124..251126 run compute default float bs.animation:eval/2 1000
assert result 11499..11501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1003233..1003235 run compute default float bs.animation:eval/0 1000
assert result -496767..-496765 run compute default float bs.animation:eval/1 1000
assert result 251967..251969 run compute default float bs.animation:eval/2 1000
assert result 11124..11126 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1003999..1004001 run compute default float bs.animation:eval/0 1000
assert result -496001..-495999 run compute default float bs.animation:eval/1 1000
assert result 252999..253001 run compute default float bs.animation:eval/2 1000
assert result 9999..10001 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]
