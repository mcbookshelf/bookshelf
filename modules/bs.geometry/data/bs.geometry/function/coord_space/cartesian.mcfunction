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

data modify storage bs:out geometry.shape set value {type:"coord_space",coord_type:"cartesian"}
data modify storage bs:data geometry.log.path set value "bs.geometry:get_cartesian_space"

function bs.geometry:shape/get_origin

function bs.geometry:shape/get_ijk

tp B5-0-0-0-1 -30000000 1000 1600
