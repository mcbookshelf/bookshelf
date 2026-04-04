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

# Repeat integer 3 times
function #bs.collection:repeat {value: 5, count: 3}
assert data storage bs:out {collection: {value: [5, 5, 5]}}

# Repeat string 2 times
function #bs.collection:repeat {value: "'a'", count: 2}
assert data storage bs:out {collection: {value: ["a", "a"]}}

# Repeat double 2 times
function #bs.collection:repeat {value: 1.5d, count: 2}
assert data storage bs:out {collection: {value: [1.5d, 1.5d]}}

# Repeat object 2 times
function #bs.collection:repeat {value: "{foo:'bar'}", count: 2}
assert data storage bs:out {collection: {value: [{foo: "bar"}, {foo: "bar"}]}}

# Repeat 0 times
function #bs.collection:repeat {value: 5, count: 0}
assert data storage bs:out {collection: {value: []}}

# Repeat error: negative count
data modify storage bs:out collection.value set value ["untouched"]
execute store success score #success bs.ctx run function #bs.collection:repeat {value: 5, count: -1}
assert score #success bs.ctx matches 0
assert data storage bs:out {collection: {value: ["untouched"]}}
