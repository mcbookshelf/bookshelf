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

execute store result storage bs:ctx x double .000001 store result score #i bs.ctx store result score #x bs.ctx run data get storage bs:out hitbox.shape[-1][0] 62500
execute store result storage bs:ctx y double .000001 store result score #j bs.ctx store result score #y bs.ctx run data get storage bs:out hitbox.shape[-1][1] 62500
execute store result storage bs:ctx z double .000001 store result score #k bs.ctx store result score #z bs.ctx run data get storage bs:out hitbox.shape[-1][2] 62500
execute store result score #l bs.ctx run data get storage bs:out hitbox.shape[-1][3] 62500
execute store result score #m bs.ctx run data get storage bs:out hitbox.shape[-1][4] 62500
execute store result score #n bs.ctx run data get storage bs:out hitbox.shape[-1][5] 62500
