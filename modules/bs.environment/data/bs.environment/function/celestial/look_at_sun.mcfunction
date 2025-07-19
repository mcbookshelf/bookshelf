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

execute store result score $environment.celestial_angle.day bs.in run time query day
execute store result score $environment.celestial_angle.daytime bs.in run time query daytime
# scaling factor
data modify storage bs:ctx z set value 1000f
function bs.environment:celestial/get_sun_angle_internal
execute if score $environment.celestial_angle.daytime bs.in matches 6000..18000 run function bs.environment:celestial/rotate_90 with storage bs:out environment
execute unless score $environment.celestial_angle.daytime bs.in matches 6000..18000 run function bs.environment:celestial/rotate_-90 with storage bs:out environment
