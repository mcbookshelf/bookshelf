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

data modify storage bs:in math.loga set value {x:28.0,a:5}
function #bs.math:loga
execute store result score #r bs.ctx run data get storage bs:out math.loga 10000
assert score #r bs.ctx matches 20703..20705

data modify storage bs:in math.loga set value {x:123456789.0,a:3}
function #bs.math:loga
execute store result score #r bs.ctx run data get storage bs:out math.loga 10000
assert score #r bs.ctx matches 169589..169591

data modify storage bs:in math.loga set value {x:1234.4321,a:9}
function #bs.math:loga
execute store result score #r bs.ctx run data get storage bs:out math.loga 10000
assert score #r bs.ctx matches 32396..32398
