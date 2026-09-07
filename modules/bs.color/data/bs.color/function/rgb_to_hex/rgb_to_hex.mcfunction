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

$data modify storage bs:ctx _ set value {rgb:$(color)}

data modify storage bs:ctx x set from storage bs:ctx _.rgb[0]
data modify storage bs:ctx y set from storage bs:ctx _.rgb[1]
data modify storage bs:ctx z set from storage bs:ctx _.rgb[2]
data remove storage bs:ctx w
data modify storage bs:ctx w set from storage bs:ctx _.rgb[3]

execute unless data storage bs:ctx w run function bs.color:rgb_to_hex/get_hexes with storage bs:ctx
execute unless data storage bs:ctx w run return run function bs.color:rgb_to_hex/concat_hexes with storage bs:ctx _

function bs.color:rgb_to_hex/get_hexes_a with storage bs:ctx
function bs.color:rgb_to_hex/concat_hexes_a with storage bs:ctx _
