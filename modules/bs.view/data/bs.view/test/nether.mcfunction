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

# @template ward:empty/9x9x9
# @dimension minecraft:the_nether
# @dummy ~4.5 ~ ~4.5

# in another dimension, a position behind a stone is still hidden and one in front of it seen
tp @s ~4.5 ~ ~4.5 0 0
setblock ~4 ~1 ~6 minecraft:stone
assert not run execute positioned ~4.5 ~1.5 ~7.5 run function #bs.view:can_see.in {with:{}}
assert run execute positioned ~4.5 ~1.5 ~5.5 run function #bs.view:can_see.in {with:{}}
