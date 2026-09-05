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

data modify storage bs:ctx h set from entity @s Health
$return run data modify storage bs:out health.get_helth set compute default float {type:"mul",inputs:[$(scale),{type:"add",inputs:[{type:"storage",storage:"bs:ctx",path:"h"},{type:"mul",inputs:[0.00001,{type:"from_int",input:{type:"score",target:"this",score:"bs.hmod"}}]}]}]}
