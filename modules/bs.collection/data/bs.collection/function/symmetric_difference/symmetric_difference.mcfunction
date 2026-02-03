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

# A - B
data modify storage bs:ctx _.sym_diff.a set from storage bs:out collection.value
data modify storage bs:ctx _.sym_diff.b set from storage bs:in collection

function #bs.collection:difference
data modify storage bs:ctx _.sym_diff.res1 set from storage bs:out collection.value

# B - A
data modify storage bs:out collection.value set from storage bs:ctx _.sym_diff.b
data modify storage bs:in collection set from storage bs:ctx _.sym_diff.a

function #bs.collection:difference
data modify storage bs:ctx _.sym_diff.res2 set from storage bs:out collection.value

# Combine
data modify storage bs:out collection.value set value []
data modify storage bs:out collection.value append from storage bs:ctx _.sym_diff.res1[]
data modify storage bs:out collection.value append from storage bs:ctx _.sym_diff.res2[]
