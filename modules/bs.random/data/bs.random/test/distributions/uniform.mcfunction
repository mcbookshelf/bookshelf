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

execute store result score #0 bs.ctx run function #bs.random:uniform {min:-10000000,max:10000000}
execute store result score #1 bs.ctx run function #bs.random:uniform {min:-10000000,max:10000000}
execute store result score #2 bs.ctx run function #bs.random:uniform {min:-10000000,max:10000000}
execute store result score #3 bs.ctx run function #bs.random:uniform {min:-10000000,max:10000000}
execute store result score #4 bs.ctx run function #bs.random:uniform {min:-10000000,max:10000000}
execute if score #0 bs.ctx = #1 bs.ctx if score #1 bs.ctx = #2 bs.ctx if score #2 bs.ctx = #3 bs.ctx if score #3 bs.ctx = #4 bs.ctx run fail "The uniform distribution should not always return the same value"
