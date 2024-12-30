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

execute unless score #x bs.ctx matches -1073741823..1073741823 store result storage bs:ctx x float .0000000004656612873077392578125 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -1073741823..1073741823 run return run scoreboard players add #e bs.ctx 7
execute unless score #x bs.ctx matches -536870911..536870911 store result storage bs:ctx x float .000000000931322574615478515625 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -536870911..536870911 run return run scoreboard players add #e bs.ctx 6
execute unless score #x bs.ctx matches -268435455..268435455 store result storage bs:ctx x float .00000000186264514923095703125 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -268435455..268435455 run return run scoreboard players add #e bs.ctx 5
execute unless score #x bs.ctx matches -134217727..134217727 store result storage bs:ctx x float .0000000037252902984619140625 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -134217727..134217727 run return run scoreboard players add #e bs.ctx 4
execute unless score #x bs.ctx matches -67108863..67108863 store result storage bs:ctx x float .000000007450580596923828125 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -67108863..67108863 run return run scoreboard players add #e bs.ctx 3
execute unless score #x bs.ctx matches -33554431..33554431 store result storage bs:ctx x float .00000001490116119384765625 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -33554431..33554431 run return run scoreboard players add #e bs.ctx 2
execute unless score #x bs.ctx matches -16777215..16777215 store result storage bs:ctx x float .0000000298023223876953125 run scoreboard players get #x bs.ctx
execute unless score #x bs.ctx matches -16777215..16777215 run return run scoreboard players add #e bs.ctx 1
execute store result storage bs:ctx x float .000000059604644775390625 run scoreboard players get #x bs.ctx
