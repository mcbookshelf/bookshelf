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

# if probabilty is 1, should stop at first trial
function #bs.random:geometric {probability:1}
assert score $random.geometric bs.out matches 1

# if probability is 0, should not stop and should reach the bound (1000)
function #bs.random:geometric {probability:0}
assert score $random.geometric bs.out matches 1000
