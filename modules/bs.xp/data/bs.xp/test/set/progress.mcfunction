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
# @dummy

function #bs.xp:set_progress {progress:0.5}
assert data entity @s {XpP:0.5f}

function #bs.xp:set_progress {progress:0.1}
assert data entity @s {XpP:0.1f}

function #bs.xp:set_progress {progress:2.0}
assert data entity @s {XpP:1.0f}
