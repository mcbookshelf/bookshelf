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

$scoreboard objectives remove $(id)
$data remove storage bs:data sidebar[{id:'$(id)'}]

function #bs.log:error { \
  namespace: "bs.sidebar", \
  path: "#bs.sidebar:create", \
  tag: "create", \
  message: '[{"text":"The line at position ","color":"red"},{"score":{"name":"#i","objective":"bs.ctx"}},{"text":" must have valid JSON text components."}]', \
}
