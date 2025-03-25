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

data modify storage bs:in spline.evaluate_bspline set value {points:[[75.54384823328081, -87.9696584636444], [33.21180527530038, -38.524583482130794], [-95.57051110063412, 32.10923111255718], [-99.52387608063984, 6.461883959073475]],time:0.02}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches 17074..17076
assert score #y bs.ctx matches -33789..-33787

data modify storage bs:in spline.evaluate_bspline set value {points:[[33.198769040318496, 54.59608568752947], [-44.55880546259288, -98.40353010671254], [12.361525618896806, -74.76080866780063], [-61.70624948500028, -79.75562981590267]],time:0.78}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches -10283..-10281
assert score #y bs.ctx matches -81915..-81913

data modify storage bs:in spline.evaluate_bspline set value {points:[[-84.49428359915181, -90.09232255643565], [46.205033557252875, -68.88780140893556], [94.04667259860861, -12.165613889547174], [-9.449254746170837, 96.3679802572556]],time:0.312}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches 55867..55869
assert score #y bs.ctx matches -49001..-48999

data modify storage bs:in spline.evaluate_bspline set value {points:[[-44.878499881278785, -69.52080384810097], [49.76544896827383, 26.822342247574937], [-17.621174090130552, -63.724424683359885], [-45.303462745371846, 51.78484596962153]],time:0.391}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches 17712..17714
assert score #y bs.ctx matches -13565..-13563

data modify storage bs:in spline.evaluate_bspline set value {points:[[25.050095875282025, 22.187424500633696], [75.86188962223858, 59.44661319908553], [29.607898074941147, 19.973799716978547], [96.39555847532267, 12.748208154804615]],time:0.28}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches 57285..57287
assert score #y bs.ctx matches 43738..43740

data modify storage bs:in spline.evaluate_bspline set value {points:[[12.378605360123899, -54.954309168018625], [-57.36522890471352, -20.905583948843784], [-12.242604115243807, 17.13599205825473], [-87.52342547658452, 64.24318765574125]],time:0.731}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches -31848..-31846
assert score #y bs.ctx matches 7505..7507

data modify storage bs:in spline.evaluate_bspline set value {points:[[10.224092991124948, 17.073605584595896], [-3.0137437026726843, -12.79304334781645], [-47.41410948996405, -0.35575572799389477], [89.97983422446393, -56.08056977228779]],time:0.368}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches -19155..-19153
assert score #y bs.ctx matches -7003..-7001

data modify storage bs:in spline.evaluate_bspline set value {points:[[62.13529353086241, 53.667609618550784], [33.07683787926831, 51.00447519805206], [-79.93277235232561, -84.06381865804697], [-83.08522081574417, -45.331267182574344]],time:0.002}
function #bs.spline:evaluate_bspline
execute store result score #x bs.ctx run data get storage bs:out spline.evaluate_bspline[0] 1000
execute store result score #y bs.ctx run data get storage bs:out spline.evaluate_bspline[1] 1000
assert score #x bs.ctx matches 18942..18944
assert score #y bs.ctx matches 28798..28800
