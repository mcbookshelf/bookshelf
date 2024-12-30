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

data modify storage bs:data log.history append value {}
data modify entity B5-0-0-0-2 text set from storage bs:data log.message
data modify storage bs:data log.history[-1].severity set from storage bs:in log.severity
data modify storage bs:data log.history[-1].namespace set from storage bs:in log.namespace
data modify storage bs:data log.history[-1].tag set from storage bs:in log.tag
data modify storage bs:data log.history[-1].message set from entity B5-0-0-0-2 text
execute if data storage bs:data log.history[4096] run data remove storage bs:data log.history[0]
