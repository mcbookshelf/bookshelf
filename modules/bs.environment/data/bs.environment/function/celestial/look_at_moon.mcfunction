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

execute store result storage bs:ctx y float 0.001 run function bs.environment:celestial/get_moon_angle
execute store result score #t bs.ctx run time query daytime
execute if score #t bs.ctx matches 6000..18000 run function bs.environment:celestial/rotate_-90 with storage bs:ctx
execute unless score #t bs.ctx matches 6000..18000 run function bs.environment:celestial/rotate_90 with storage bs:ctx
