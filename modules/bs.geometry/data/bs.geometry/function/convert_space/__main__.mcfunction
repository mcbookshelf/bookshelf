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

data modify storage bs.geometry:convert_space out set value {}

data modify storage bs.geometry: shapes set from storage bs.geometry:convert_space in
data modify storage bs.geometry:rotate_axis in set from storage bs.geometry:convert_space in

#this function accept an array of 2shapes as input
execute if function bs.geometry:__internal__/error/2array run return fail
#a point and a coord space
execute if function bs.geometry:__internal__/error/need_point run return fail
execute if function bs.geometry:__internal__/error/need_coord_space run return fail

execute if data storage bs.geometry: shapes[{type:"point",coord_type:"cylindric"}] run function bs.geometry:convert_space/cylindric_to_cartesian
execute if data storage bs.geometry: shapes[{type:"point",coord_type:"spherical"}] run function bs.geometry:convert_space/spheric_to_cartesian

execute unless data storage bs.geometry: shapes[{type:"point",coord_type:"cartesian"}] run data modify storage bs.geometry:rotate_axis in[{type:"point"}] set from storage bs.geometry:convert_space out

function bs.geometry:rotate_axis/__main__
execute if data storage bs.geometry: shapes[{type:"point",coord_type:"cartesian"}] run return run data modify storage bs.geometry:convert_space out set from storage bs.geometry:rotate_axis out[{type:"point"}]

data modify storage bs.geometry: shapes[{type:"point"}] set from storage bs.geometry:rotate_axis out

execute if data storage bs.geometry: shapes[{type:"coord_space",coord_type:"cylindric"}] run function bs.geometry:convert_space/cartesian_to_cylindric
execute if data storage bs.geometry: shapes[{type:"coord_space",coord_type:"spherical"}] run function bs.geometry:convert_space/cartesian_to_spheric
