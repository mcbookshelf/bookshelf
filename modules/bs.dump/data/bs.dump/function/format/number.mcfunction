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

data modify storage bs:dump ctx.char set string storage bs:dump ctx.value -1
execute unless data storage bs:dump ctx{char:"b"} \
  unless data storage bs:dump ctx{char:"s"} \
  unless data storage bs:dump ctx{char:"l"} \
  unless data storage bs:dump ctx{char:"f"} \
  unless data storage bs:dump ctx{char:"d"} \
  run data remove storage bs:dump ctx.char
execute if data storage bs:dump ctx.char run data modify storage bs:dump ctx.value set string storage bs:dump ctx.value 0 -1

$data modify storage bs:dump output append value [{text:"",color:"$(number)"},{text:"",color:"$(type)"}]
data modify storage bs:dump output[-1][0].text set from storage bs:dump ctx.value
data modify storage bs:dump output[-1][1].text set from storage bs:dump ctx.char
