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

data modify storage bs:out geometry.coord_space set value {}

#this function accept an array of 2shapes as input
execute if function bs.geometry:error/2array run return fail
#a point and a plane/cylinder/sphere

execute if function bs.geometry:error/need_point run return fail
execute if function bs.geometry:error/need_coord_space run return fail


data modify storage bs:ctx temp set from storage bs:in geometry.shapes

execute if data storage bs:in geometry.shapes[{type:"point",coord_type:"cylindric"}] run function bs.geometry:transform/coord_space/cylindric_to_cartesian
execute if data storage bs:in geometry.shapes[{type:"point",coord_type:"spherical"}] run function bs.geometry:transform/coord_space/spheric_to_cartesian

execute unless data storage bs:in geometry.shapes[{type:"point",coord_type:"cartesian"}] run data modify storage bs:in geometry.shapes[{type:"point"}] set from storage bs:out geometry.coord_space

function bs.geometry:transform/rot_axis
data modify storage bs:in geometry.shapes[{type:"point"}] set from storage bs:out geometry.rot_axis

execute if data storage bs:in geometry.shapes[{type:"coord_space",coord_type:"cylindric"}] run function bs.geometry:transform/coord_space/cartesian_to_cylindric
execute if data storage bs:in geometry.shapes[{type:"coord_space",coord_type:"spherical"}] run function bs.geometry:transform/coord_space/cartesian_to_spheric

data modify storage bs:in geometry.shapes set from storage bs:ctx temp
