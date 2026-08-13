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

data modify storage bs:ctx _ set from storage bs:data animation[-1].defs[0]._

data modify storage bs:ctx _[0].t set value 0
data modify storage bs:ctx @ append from storage bs:ctx _[{t:0}]
data remove storage bs:ctx _[{t:0}]
data modify storage bs:ctx _ append from storage bs:ctx @[]
data modify storage bs:ctx _[].t set value 0
data remove storage bs:ctx @

function bs.animation:step/eval with storage bs:ctx _[0]

$$(run)

data modify storage bs:data animation[-1].nbt.data."bs.animation" append from storage bs:data animation[-1].defs[0]
data modify storage bs:data animation[-1].nbt.data."bs.animation"[-1]._ set from storage bs:ctx _
data remove storage bs:data animation[-1].defs[0]

execute if data storage bs:data animation[-1].defs[0] run function bs.animation:reset/many with storage bs:data animation[-1].defs[0]
