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

$return run data modify storage bs:out color.hex_to_int set compute default {type:"minecraft:add",inputs:[{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(z)"},{type:"minecraft:mul",inputs:[256,{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(y)"}]},{type:"minecraft:mul",inputs:[65536,{type:"minecraft:storage",storage:"bs:const",path:"color.hex_values.$(x)"}]}]} integer
