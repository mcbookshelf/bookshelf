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

$execute store success score #s bs.ctx run data modify storage bs:ctx _ set from storage bs:const block.types."$(type)"
execute if score #s bs.ctx matches 0 run return fail
execute store success score #s bs.ctx run data modify storage bs:out block.group set from storage bs:ctx _.group
execute if score #s bs.ctx matches 1 run data modify storage bs:out block set from storage bs:ctx _
execute if score #s bs.ctx matches 0 store success score #s bs.ctx run data modify storage bs:out block.type set from storage bs:ctx _.type
execute if score #s bs.ctx matches 0 run return fail
