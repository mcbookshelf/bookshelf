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

#this function accept an array of 2shapes as input

#a point and a plane 
execute if data storage bs:in geometry.shapes[{type:"point"}] if data storage bs:in geometry.shapes[{type:"plane"}] run return run function bs.geometry:transform/orth_proj/point_plane

#a line and a plane 
execute if data storage bs:in geometry.shapes[{type:"line"}] if data storage bs:in geometry.shapes[{type:"plane"}] run return run function bs.geometry:transform/orth_proj/line_plane






