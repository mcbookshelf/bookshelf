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

execute in minecraft:overworld as B5-0-0-0-1 run function bs.vector:normalize/compute
$execute store result score $vector.normalize.0 bs.out run data get storage bs:ctx _[0] $(scale)
$execute store result score $vector.normalize.1 bs.out run data get storage bs:ctx _[1] $(scale)
$execute store result score $vector.normalize.2 bs.out run data get storage bs:ctx _[2] $(scale)
