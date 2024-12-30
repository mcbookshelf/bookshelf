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

execute unless data storage bs:ctx _[2][1] run data modify storage bs:data dump[-1]._ set string storage bs:data dump[-1].var -1
execute unless data storage bs:ctx _[2][1] run data modify storage bs:data dump[-1].var set string storage bs:data dump[-1].var 0 -1
$data modify entity B5-0-0-0-2 text set value '[{"storage":"bs:data","nbt":"dump[-1].var","color":"$(number)"},{"storage":"bs:data","nbt":"dump[-1]._","color":"$(type)"}]'
data modify storage bs:out dump append from entity B5-0-0-0-2 text
