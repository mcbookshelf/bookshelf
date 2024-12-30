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

$data modify storage bs:ctx _ set value {rgb:$(color)}

data modify storage bs:ctx x set from storage bs:ctx _.rgb[0]
data modify storage bs:ctx y set from storage bs:ctx _.rgb[1]
data modify storage bs:ctx z set from storage bs:ctx _.rgb[2]

function bs.color:rgb_to_hex/get_hexes with storage bs:ctx
function bs.color:rgb_to_hex/concat_hexes with storage bs:ctx _
