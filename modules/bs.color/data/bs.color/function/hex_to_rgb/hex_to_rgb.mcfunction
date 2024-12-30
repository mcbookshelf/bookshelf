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

$data modify storage bs:ctx _ set value '$(color)'
data modify storage bs:ctx x set string storage bs:ctx _ 1 3
data modify storage bs:ctx y set string storage bs:ctx _ 3 5
data modify storage bs:ctx z set string storage bs:ctx _ 5 7

return run function bs.color:hex_to_rgb/convert_hexes with storage bs:ctx
