# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

$data modify storage bs:ctx _.s.3 set string storage bs:in string.insert.str 0 $(index)
data modify storage bs:ctx _.s.2 set string storage bs:in string.insert.needle
$data modify storage bs:ctx _.s.1 set string storage bs:in string.insert.str $(index)

function bs.string:concat/combine/2c with storage bs:ctx _.s

data modify storage bs:out string.insert set from storage bs:ctx _.s.1
