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

# Append current value to result if not already in it and also not in the other input collection
data modify storage bs:ctx _.other set from storage bs:ctx _.sym
data modify storage bs:ctx _.other append from storage bs:out collection.value[]

execute unless function bs.collection:utils/contains run data modify storage bs:out collection.value append from storage bs:ctx _.value[0]

# Next iteration
data remove storage bs:ctx _.value[0]
execute if data storage bs:ctx _.value[0] run function bs.collection:symmetric_difference/symmetric_difference_rec2
