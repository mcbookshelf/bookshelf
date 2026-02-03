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
# @dummy

# Empty
data modify storage bs:out collection.value set value []
function #bs.collection:foreach {run: "tellraw @a 'value'"}
assert not chat "value"

# Print
data modify storage bs:out collection.value set value [0, 1, 2, 3]
function #bs.collection:foreach {run: "tellraw @a {nbt:'collection.value',storage:'bs:lambda'}"}
assert chat "0"
assert chat "1"
assert chat "2"
assert chat "3"

# Index
data modify storage bs:out collection.value set value [10, 11, 12, 13]
function #bs.collection:foreach {run: "tellraw @a {nbt:'collection.index',storage:'bs:lambda'}"}
assert chat "0"
assert chat "1"
assert chat "2"
assert chat "3"
