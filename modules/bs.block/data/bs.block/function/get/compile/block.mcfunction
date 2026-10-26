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

# return the block string: {type}
execute unless data storage bs:out block._ run return run data modify storage bs:out block.block set from storage bs:out block.type

# generate the state string
data modify storage bs:ctx _ set value {0:"",1:"",2:"",3:"",4:"",5:"",6:"",7:""}
data modify storage bs:ctx _ merge from storage bs:out block._
function bs.block:get/compile/concat/state with storage bs:ctx _

# return the block string: {type}{state}
return run function bs.block:get/compile/concat/block with storage bs:out block
