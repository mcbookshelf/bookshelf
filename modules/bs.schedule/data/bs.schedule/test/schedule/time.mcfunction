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

function #bs.schedule:schedule {run:"scoreboard players set #packtest.schedule.time bs.data 1",with:{time:5}}
assert not score #packtest.schedule.time bs.data matches 1
await delay 1t
assert not score #packtest.schedule.time bs.data matches 1
await delay 1t
assert not score #packtest.schedule.time bs.data matches 1
await delay 1t
assert not score #packtest.schedule.time bs.data matches 1
await delay 1t
assert not score #packtest.schedule.time bs.data matches 1
await score #packtest.schedule.time bs.data matches 1

function #bs.schedule:schedule {run:"scoreboard players set #packtest.schedule.time bs.data 2",with:{time:1,unit:"s"}}
assert not score #packtest.schedule.time bs.data matches 2
await delay 19t
assert not score #packtest.schedule.time bs.data matches 2
await score #packtest.schedule.time bs.data matches 2
