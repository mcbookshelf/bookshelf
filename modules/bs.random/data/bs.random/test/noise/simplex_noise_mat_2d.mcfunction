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

function #bs.random:simplex_noise_mat_2d {width:0,height:8,with:{}}
assert result 0 run data get storage bs:out random.simplex_noise_mat_2d

function #bs.random:simplex_noise_mat_2d {width:8,height:0,with:{}}
assert result 0 run data get storage bs:out random.simplex_noise_mat_2d

function #bs.random:simplex_noise_mat_2d {width:3,height:2,with:{}}
assert result 2 run data get storage bs:out random.simplex_noise_mat_2d
assert result 3 run data get storage bs:out random.simplex_noise_mat_2d[0]
assert result 3 run data get storage bs:out random.simplex_noise_mat_2d[1]
