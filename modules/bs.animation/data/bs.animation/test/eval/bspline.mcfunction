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

data modify storage bs.animation: stack append value {_:[{k:1,r:1,n:1,i:0,t:0.0f,d:100,p:[[0.0f,0.0f,0.0f,0.0f],[2.0f,1.0f,0.0f,3.0f],[4.0f,1.0f,2.0f,3.0f],[6.0f,0.0f,2.0f,0.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 1999..2001 run compute default float bs.animation:eval/0 1000
assert result 832..834 run compute default float bs.animation:eval/1 1000
assert result 332..334 run compute default float bs.animation:eval/2 1000
assert result 2499..2501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 2499..2501 run compute default float bs.animation:eval/0 1000
assert result 926..928 run compute default float bs.animation:eval/1 1000
assert result 634..636 run compute default float bs.animation:eval/2 1000
assert result 2780..2782 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 2999..3001 run compute default float bs.animation:eval/0 1000
assert result 957..959 run compute default float bs.animation:eval/1 1000
assert result 999..1001 run compute default float bs.animation:eval/2 1000
assert result 2874..2876 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 3499..3501 run compute default float bs.animation:eval/0 1000
assert result 926..928 run compute default float bs.animation:eval/1 1000
assert result 1363..1365 run compute default float bs.animation:eval/2 1000
assert result 2780..2782 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 3999..4001 run compute default float bs.animation:eval/0 1000
assert result 832..834 run compute default float bs.animation:eval/1 1000
assert result 1665..1667 run compute default float bs.animation:eval/2 1000
assert result 2499..2501 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]

data modify storage bs.animation: stack append value {_:[{k:1,r:1,n:1,i:0,t:0.0f,d:100,p:[[1000.0f,-500.0f,250.0f,10.0f],[1002.0f,-499.0f,250.0f,13.0f],[1004.0f,-499.0f,252.0f,13.0f],[1006.0f,-500.0f,252.0f,10.0f]]}]}

data modify storage bs.animation: stack[-1]._[0].t set value 0.0f
assert result 1001999..1002001 run compute default float bs.animation:eval/0 1000
assert result -499168..-499166 run compute default float bs.animation:eval/1 1000
assert result 250332..250334 run compute default float bs.animation:eval/2 1000
assert result 12499..12501 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.25f
assert result 1002499..1002501 run compute default float bs.animation:eval/0 1000
assert result -499074..-499072 run compute default float bs.animation:eval/1 1000
assert result 250634..250636 run compute default float bs.animation:eval/2 1000
assert result 12780..12782 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.5f
assert result 1002999..1003001 run compute default float bs.animation:eval/0 1000
assert result -499043..-499041 run compute default float bs.animation:eval/1 1000
assert result 250999..251001 run compute default float bs.animation:eval/2 1000
assert result 12874..12876 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 0.75f
assert result 1003499..1003501 run compute default float bs.animation:eval/0 1000
assert result -499074..-499072 run compute default float bs.animation:eval/1 1000
assert result 251363..251365 run compute default float bs.animation:eval/2 1000
assert result 12780..12782 run compute default float bs.animation:eval/3 1000

data modify storage bs.animation: stack[-1]._[0].t set value 1.0f
assert result 1003999..1004001 run compute default float bs.animation:eval/0 1000
assert result -499168..-499166 run compute default float bs.animation:eval/1 1000
assert result 251665..251667 run compute default float bs.animation:eval/2 1000
assert result 12499..12501 run compute default float bs.animation:eval/3 1000

data remove storage bs.animation: stack[-1]
