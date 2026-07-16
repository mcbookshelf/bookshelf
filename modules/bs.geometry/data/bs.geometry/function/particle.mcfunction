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

data modify storage bs:ctx a set from storage bs:in geometry.shapes[0].origin[0]
data modify storage bs:ctx b set from storage bs:in geometry.shapes[0].origin[1]
data modify storage bs:ctx c set from storage bs:in geometry.shapes[0].origin[2]

function bs.geometry:particle_macro with storage bs:ctx

data modify storage bs:ctx a set from storage bs:in geometry.shapes[1].origin[0]
data modify storage bs:ctx b set from storage bs:in geometry.shapes[1].origin[1]
data modify storage bs:ctx c set from storage bs:in geometry.shapes[1].origin[2]

function bs.geometry:particle_macro with storage bs:ctx

