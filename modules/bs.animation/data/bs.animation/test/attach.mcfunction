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

summon marker ~ ~ ~ {Tags:["ward.animation.attach"]}

# linear: 4 points -> 3 segments
data modify storage bs.animation:attach in set value {id:"linear",run:"<apply>",type:"linear",duration:30,points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear",run:"<apply>",k:4,r:1,n:3,i:0,t:0f,d0:30,d:30}]
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear"}].p0
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear"}].p
assert result 6 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear"}].p[3][0]
data modify storage bs.animation:attach in set value {id:"linear_list",run:"",type:"linear",duration:[5,10,15],points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear_list",k:4,n:3}]
assert result 3 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear_list"}].d0
assert result 3 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear_list"}].d
assert result 15 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"linear_list"}].d[2]

# step: 4 points -> 3 segments
data modify storage bs.animation:attach in set value {id:"step",run:"",type:"step",duration:30,points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"step",k:5,r:1,n:3}]
data modify storage bs.animation:attach in set value {id:"step_list",run:"",type:"step",duration:[7],points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"step_list",n:1}]

# bezier: 8 points -> 2 segments, the leftover point stays in the list unused
data modify storage bs.animation:attach in set value {id:"bezier",run:"",type:"bezier",duration:30,points:[[0,0,0],[1,1,0],[2,1,0],[3,0,0],[4,1,0],[5,1,0],[6,0,0],[7,7,7]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bezier",k:0,r:3,n:2}]
assert result 8 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bezier"}].p0
data modify storage bs.animation:attach in set value {id:"bezier_list",run:"",type:"bezier",duration:[10],points:[[0,0,0],[1,1,0],[2,1,0],[3,0,0],[4,1,0],[5,1,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bezier_list",n:1,d0:[10],d:[10]}]

# hermite: 6 points -> 2 segments
data modify storage bs.animation:attach in set value {id:"hermite",run:"",type:"hermite",duration:30,points:[[0,0,0],[1,0,0],[2,1,0],[1,0,0],[4,4,0],[1,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"hermite",k:3,r:2,n:2}]
data modify storage bs.animation:attach in set value {id:"hermite_list",run:"",type:"hermite",duration:[7,8],points:[[0,0,0],[1,0,0],[2,1,0],[1,0,0],[4,4,0],[1,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"hermite_list",n:2}]
assert result 2 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"hermite_list"}].d0

# catmull_rom: phantom ends 2*p0 - p1 = [-2,-1,0] and 2*p3 - p2 = [8,-4,0], 4 points -> 6 in p0, 3 segments
data modify storage bs.animation:attach in set value {id:"catmull_rom",run:"",type:"catmull_rom",duration:30,points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom",k:2,r:1,n:3}]
assert result 6 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0
assert result -2 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[0][0]
assert result -1 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[0][1]
assert result 0 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[0][2]
assert result 0 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[1][0]
assert result 6 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[4][0]
assert result 8 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[5][0]
assert result -4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[5][1]
assert result 0 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[5][2]
assert result 3 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_rom"}].p0[0]

# catmull_rom with 4 components: the phantom follows the point length
data modify storage bs.animation:attach in set value {id:"catmull_4d",run:"",type:"catmull_rom",duration:30,points:[[0,0,0,1],[2,1,0,3]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_4d",n:1}]
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_4d"}].p0[0]
assert result -1 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_4d"}].p0[0][3]
assert result 5 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_4d"}].p0[3][3]

# catmull_rom with a list longer than the segments: n stays 3, the extra entries are kept unused
data modify storage bs.animation:attach in set value {id:"catmull_list",run:"",type:"catmull_rom",duration:[1,2,3,4,5],points:[[0,0,0],[2,1,0],[4,4,0],[6,0,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_list",n:3}]
assert result 5 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_list"}].d0
assert result 6 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_list"}].p0
assert result -2 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"catmull_list"}].p0[0][0]

# bspline: ends tripled, 3 points -> 7 in p0, 4 segments
data modify storage bs.animation:attach in set value {id:"bspline",run:"",type:"bspline",duration:30,points:[[0,0,0],[2,1,0],[4,4,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline",k:1,r:1,n:4}]
assert result 7 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0
assert result 0 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[0][0]
assert result 0 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[2][0]
assert result 2 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[3][0]
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[4][0]
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[6][0]
assert result 4 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline"}].p0[6][1]

# bspline with a list shorter than the padded segments: 4 possible, capped to 2, padding unaffected
data modify storage bs.animation:attach in set value {id:"bspline_list",run:"",type:"bspline",duration:[10,20],points:[[0,0,0],[2,1,0],[4,4,0]]}
assert run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline_list",n:2}]
assert result 7 run data get entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"bspline_list"}].p0

# failures: nothing is attached
data modify storage bs.animation:attach in set value {type:"linear",duration:30,points:[[0,0,0],[1,1,1]]}
assert not run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"type",duration:30,points:[[0,0,0],[1,1,1]]}
assert not data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"type"}]
assert not run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
data modify storage bs.animation:attach in set value {id:"few",run:"",type:"bezier",duration:30,points:[[0,0,0],[1,1,1]]}
assert not run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert not data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"few"}]
data modify storage bs.animation:attach in set value {id:"one",run:"",type:"linear",duration:30,points:[[0,0,0]]}
assert not run execute as @n[type=marker,tag=ward.animation.attach] run function #bs.animation:attach
assert not data entity @n[type=marker,tag=ward.animation.attach] data."bs.animation"[{id:"one"}]

kill @n[type=marker,tag=ward.animation.attach]
