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

$execute store result storage bs.color:hex_to_rgb out[0] float 0.00392156862745098 run data get storage bs.color: byte.$(r)
$execute store result storage bs.color:hex_to_rgb out[1] float 0.00392156862745098 run data get storage bs.color: byte.$(g)
$execute store result storage bs.color:hex_to_rgb out[2] float 0.00392156862745098 run data get storage bs.color: byte.$(b)
