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

# For each animated part:
# 1. If the animation uses keyframes, convert them to a spline.
# 2. Bake the spline polynomials and store them in _.

$data modify storage bs:ctx _ set from storage $(uses)
function bs.animation:bake/any
$data modify storage $(uses) set from storage bs:ctx _
