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

execute unless data storage bs:ctx {_:":"} run data modify storage bs:data dump[-1].key set string storage bs:data dump[-1].key 1 -1
$execute unless data storage bs:ctx {_:":"} run data modify entity B5-0-0-0-2 text set value '[{"storage":"bs:ctx","nbt":"_"},{"storage":"bs:data","nbt":"dump[-1].key","color":"$(key)"},{"storage":"bs:ctx","nbt":"_"},{"text":": "}]'
$execute if data storage bs:ctx {_:":"} run data modify entity B5-0-0-0-2 text set value '[{"storage":"bs:data","nbt":"dump[-1].key","color":"$(key)"},{"text":": "}]'
data modify storage bs:out dump append from entity B5-0-0-0-2 text
