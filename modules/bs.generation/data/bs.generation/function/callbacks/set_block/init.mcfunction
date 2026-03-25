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

data modify storage bs:data generation[-1] merge value { mode: "replace", mask: "" }
$data modify storage bs:data generation[-1] merge value $(with)
$data modify storage bs:data generation[-1].block set value '$(block)'
data modify storage bs:data generation[-1].run set value 'function bs.generation:callbacks/set_block/run with storage bs:data generation[-1]'
execute if data storage bs:data generation[-1].masks[0] run function bs.generation:utils/block/masks/compile

function bs.generation:callbacks/set_block/run with storage bs:data generation[-1]
