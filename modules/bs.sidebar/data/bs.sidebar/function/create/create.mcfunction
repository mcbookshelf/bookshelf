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

$data modify storage bs:ctx _ set value {id:'$(objective)',name:'$(display_name)',contents:$(contents)}

# check that the objective format is valid
execute store success score #s bs.ctx run function bs.sidebar:create/check/objective with storage bs:ctx _
execute unless score #s bs.ctx matches 1 run return run function #bs.log:error { \
  namespace: "bs.sidebar", \
  path: "#bs.sidebar:create", \
  tag: "create", \
  message: '[{"text":"The objective [","color":"red"},{"storage":"bs:ctx","nbt":"_.id"},{"text":"] contain invalid characters."}]', \
}

# check that the name format is valid
execute store success score #s bs.ctx run function bs.sidebar:create/check/name with storage bs:ctx _
execute unless score #s bs.ctx matches 1 run return run function #bs.log:error { \
  namespace: "bs.sidebar", \
  path: "#bs.sidebar:create", \
  tag: "create", \
  message: '[{"text":"The name [","color":"red"},{"storage":"bs:ctx","nbt":"_.name"},{"text":"] must be a valid JSON text component."}]', \
}

# check that the contents have between 1 and 15 entries
execute store result score #l bs.ctx if data storage bs:ctx _.contents[]
execute unless score #l bs.ctx matches 1..15 run return run function #bs.log:error { \
  namespace: "bs.sidebar", \
  path: "#bs.sidebar:create", \
  tag: "create", \
  message: '[{"text":"The contents must have between 1 and 15 lines (","color":"red"},{"score":{"name":"#l","objective":"bs.ctx"}},{"text":" given)."}]', \
}

# start the recursion to create each line abort if a line failed
execute as B5-0-0-0-2 run function bs.sidebar:create/recurse/start with storage bs:ctx _
data remove entity @s CustomName
execute if score #l bs.ctx = #i bs.ctx run return 1
return run function bs.sidebar:create/recurse/abort with storage bs:ctx _
