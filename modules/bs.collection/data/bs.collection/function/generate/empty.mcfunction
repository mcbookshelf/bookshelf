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

execute if score #l bs.ctx matches ..-1 run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:generate/generate", tag: "generate", message: '"Limit must be positive"'}
execute if score #l bs.ctx matches ..-1 run return fail
data modify storage bs:out collection.value set value []
return 0
