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

execute positioned 0.0 0 0.0 rotated 0.0 0.0 run function #bs.geometry:get_plane
assert not data storage bs:out geometry.shape{coord_type:"cartesian",i:[1.0d,9.38876977589949E-41d,-1.2246468525851679E-16d],j:[0.0d,1.0d,1.2246468525851679E-16d],k:[1.2246468525851679E-16d,0.0d,1.0d],origin:[0.0d,0.0d,0.0d],type:"plane"}

execute positioned 0.0 0 0.0 rotated 0.0 0.0 run function #bs.geometry:get_line
assert not data storage bs:out geometry.shape{coord_type:"cartesian",k:[1.2246468525851679E-16d,0.0d,1.0d],origin:[0.0d,0.0d,0.0d],type:"line"}
