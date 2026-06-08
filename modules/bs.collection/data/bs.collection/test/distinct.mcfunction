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

# Distinct integers
data modify storage bs:out collection.value set value [1, 2, 2, 3, 1]
function #bs.collection:distinct
assert data storage bs:out {collection: {value: [1, 2, 3]}}

# Distinct strings
data modify storage bs:out collection.value set value ["a", "b", "a", "c"]
function #bs.collection:distinct
assert data storage bs:out {collection: {value: ["a", "b", "c"]}}

# Distinct objects
data modify storage bs:out collection.value set value [{id:1}, {id:2}, {id:1}]
function #bs.collection:distinct
assert data storage bs:out {collection: {value: [{id:1}, {id:2}]}}

# Distinct empty
data modify storage bs:out collection.value set value []
function #bs.collection:distinct
assert data storage bs:out {collection: {value: []}}

# Distinct already distinct
data modify storage bs:out collection.value set value [1, 2, 3]
function #bs.collection:distinct
assert data storage bs:out {collection: {value: [1, 2, 3]}}
