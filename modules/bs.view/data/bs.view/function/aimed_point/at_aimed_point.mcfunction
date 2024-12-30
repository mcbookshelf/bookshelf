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

# run the raycast at the entity eyes
tag @s add bs.view.this
$data modify storage bs:data raycast.on_hit_point set value 'execute as @n[tag=bs.view.this,sort=arbitrary] run $(run)'
execute at @s anchored eyes positioned ^ ^ ^ run function bs.raycast:run
tag @s remove bs.view.this
