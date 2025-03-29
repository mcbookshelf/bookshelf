# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

data modify storage bs:in spline.evaluate_hermite set value {points:[[-5.630019996680218, -11.564497946464854], [-61.59257620828023, -63.9812943034068], [-47.008899933615986, 3.8837328075691033], [-53.183384246759616, -68.91896869313084]],time:0.331}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches -21457..-21455
assert score #y bs.ctx matches -12035..-12033

data modify storage bs:in spline.evaluate_hermite set value {points:[[-0.36197044500896425, 82.06963546510528], [21.323558906850494, 43.43772639784859], [31.22066357671008, -71.18071959205272], [-31.13189813865121, -78.26017618894403]],time:0.334}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches 13325..13327
assert score #y bs.ctx matches 54450..54452

data modify storage bs:in spline.evaluate_hermite set value {points:[[83.62725180466632, -64.13300657086577], [22.110325408592658, 91.3925681011489], [30.55974780297177, 30.417604648783538], [1.041162805205559, -39.52332781235288]],time:0.556}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches 54934..54936
assert score #y bs.ctx matches 6492..6494

data modify storage bs:in spline.evaluate_hermite set value {points:[[91.74361944911084, 35.377802967947844], [-59.95667863833991, 75.18989037403881], [-51.75329191910711, -95.32320183363832], [-4.876545065520048, 21.78707885806108]],time:0.994}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches -51712..-51710
assert score #y bs.ctx matches -95437..-95435

data modify storage bs:in spline.evaluate_hermite set value {points:[[68.60561266256005, -7.739149140147902], [83.79060050212556, 78.0804021363897], [-35.08854416420483, -86.65797142094851], [36.013618899242516, 22.22742536336004]],time:0.556}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches 12325..12327
assert score #y bs.ctx matches -48294..-48292

data modify storage bs:in spline.evaluate_hermite set value {points:[[57.55621644184387, 70.32541791225998], [71.56787788434224, 3.773437001702277], [2.1705614417129766, 68.7143013697522], [60.958069891479795, -69.20195333137414]],time:0.894}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches -541..-539
assert score #y bs.ctx matches 74664..74666

data modify storage bs:in spline.evaluate_hermite set value {points:[[-85.91855268737687, -58.961550763437984], [32.787186797652794, 92.05507837702004], [-29.575619322777527, 67.16535029353145], [69.71986583270206, -47.32783229115238]],time:0.812}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches -42503..-42501
assert score #y bs.ctx matches 63976..63978

data modify storage bs:in spline.evaluate_hermite set value {points:[[-52.91650742605769, 36.994522038399055], [92.89694743755277, -3.3700589701218604], [-52.498693197891974, -59.374851719766156], [27.443975424895584, -69.82335472231327]],time:0.673}
function #bs.spline:evaluate_hermite
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_hermite[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_hermite[1] 1000
assert score #x bs.ctx matches -49984..-49982
assert score #y bs.ctx matches -25102..-25100
