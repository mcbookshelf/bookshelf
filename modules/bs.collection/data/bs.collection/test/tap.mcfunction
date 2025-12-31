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

# Basic usage
data modify storage bs:out collection.value set value [1, 2, 3]
function bs.collection:tap {run: "tellraw @a [{\"text\":\"Collection: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
assert chat "Collection: [1, 2, 3]"
assert data storage bs:out {collection: {value: [1, 2, 3]}}

# Empty collection
data modify storage bs:out collection.value set value []
function bs.collection:tap {run: "tellraw @a [{\"text\":\"Empty: \"},{\"storage\":\"bs:lambda\",\"nbt\":\"collection.value\"}]"}
assert chat "Empty: []"
assert data storage bs:out {collection: {value: []}}
