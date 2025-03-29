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

# Note: Thanks to tryashtar and PiggyPig for inspiring the idea behind this module.

$data modify storage bs:data dump.stack set value [{var:$(var),indent:"\u2000"}]
data modify storage bs:data dump.out set value [[{text:"[",color:"#cccccc"},{selector:"@s"},"] ⇒ "]]
function bs.dump:interpret/any
tellraw @a {type:"nbt",storage:"bs:data",nbt:"dump.out[]",separator:"",interpret:true}
