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

$execute as @e[tag=$(entities),tag=bs.hitbox.custom,tag=!bs.move.omit,distance=..32] run function bs.move:collision/check/entity/custom
$execute as @e[type=!$(ignored_entities),tag=$(entities),tag=!bs.hitbox.custom,tag=!bs.move.omit,dx=$(dx),dy=$(dy),dz=$(dz)] run function bs.move:collision/check/entity/any
