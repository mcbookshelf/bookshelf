# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#concat
# ------------------------------------------------------------------------------------------------------------
execute store result score #string.n_string bs.data run data get storage bs:in string.concat.list
execute if score #string.n_string bs.data matches 3.. run return run function bs.string:concat/main
execute unless score #string.n_string bs.data matches 2 run return -1

# Only 2 strings: Combine
data modify storage bs:ctx _.s.1 set from storage bs:in string.concat.list[0]
data modify storage bs:ctx _.s.2 set from storage bs:in string.concat.list[1]
function bs.string:concat/combine/1c with storage bs:ctx _.s
data modify storage bs:out string.concat set from storage bs:ctx _.s.1
data remove storage bs:ctx _.s