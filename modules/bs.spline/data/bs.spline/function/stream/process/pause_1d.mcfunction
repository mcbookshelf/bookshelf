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

execute store result storage bs:ctx _.time int 1 run scoreboard players get #t bs.ctx
execute store result storage bs:ctx _.coeffs[0] int 1 run scoreboard players get #a bs.ctx
execute store result storage bs:ctx _.coeffs[1] int 1 run scoreboard players get #b bs.ctx
execute store result storage bs:ctx _.coeffs[2] int 1 run scoreboard players get #c bs.ctx
execute store result storage bs:ctx _.coeffs[3] int 1 run scoreboard players get #d bs.ctx

data modify storage bs:data spline.stream prepend from storage bs:ctx _
schedule function bs.spline:stream/process/scheduled 1t replace
