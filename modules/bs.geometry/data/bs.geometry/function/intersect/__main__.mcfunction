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

data modify storage bs.geometry: shapes set from storage bs.geometry:intersect in

data modify storage bs.geometry:intersect out set value []

#this function accept an array of 2shapes as input
execute if function bs.geometry:__internal__/error/2array run return fail

execute if data storage bs.geometry: shapes[{type:"line"}] if data storage bs.geometry: shapes[{type:"plane"}] run return run function bs.geometry:intersect/shapes/line_plane

execute if data storage bs.geometry: shapes[{type:"line"}] if data storage bs.geometry: shapes[{type:"sphere"}] run return run function bs.geometry:intersect/shapes/line_sphere

