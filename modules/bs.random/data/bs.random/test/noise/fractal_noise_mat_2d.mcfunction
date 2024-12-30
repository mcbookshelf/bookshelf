# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

function #bs.random:fractal_noise_mat_2d {width:0,height:8,with:{}}
execute store result score #n bs.ctx if data storage bs:out random.fractal_noise_mat_2d[]
assert score #n bs.ctx matches 0

function #bs.random:fractal_noise_mat_2d {width:8,height:0,with:{}}
execute store result score #n bs.ctx if data storage bs:out random.fractal_noise_mat_2d[]
assert score #n bs.ctx matches 0

function #bs.random:fractal_noise_mat_2d {width:3,height:2,with:{}}
execute store result score #n bs.ctx if data storage bs:out random.fractal_noise_mat_2d[]
assert score #n bs.ctx matches 2
execute store result score #n bs.ctx if data storage bs:out random.fractal_noise_mat_2d[0][]
assert score #n bs.ctx matches 3
execute store result score #n bs.ctx if data storage bs:out random.fractal_noise_mat_2d[1][]
assert score #n bs.ctx matches 3
