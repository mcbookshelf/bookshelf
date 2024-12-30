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

data modify storage bs:data dump append from storage bs:data dump[-1]
data modify storage bs:data dump[-1].var set from storage bs:data dump[-1].var[0]
function bs.dump:format/any
data remove storage bs:data dump[-1]
data remove storage bs:data dump[-1].var[0]

execute if data storage bs:data dump[-1].var[0] run data modify storage bs:out dump append value '", "'
execute if data storage bs:data dump[-1].var[0] run function bs.dump:format/array/compact/loop
