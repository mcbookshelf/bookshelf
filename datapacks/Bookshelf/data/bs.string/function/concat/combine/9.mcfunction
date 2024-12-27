# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#concat
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:ctx _.s.2 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.3 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.4 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.5 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.6 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.7 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.8 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.9 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
data modify storage bs:ctx _.s.10 set from storage bs:ctx _.l[-1]
data remove storage bs:ctx _.l[-1]
function bs.string:concat/combine/9c with storage bs:ctx _.s