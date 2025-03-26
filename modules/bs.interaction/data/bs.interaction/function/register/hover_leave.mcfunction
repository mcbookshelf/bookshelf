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

execute unless entity @s[type=minecraft:interaction] run return run function bs.interaction:register/errors/entity { event: "on_hover_leave" }

$data modify storage bs:ctx _ set value { run: '$(run)', executor: $(executor), type: "hover_leave" }

execute store success score #s bs.ctx run function bs.interaction:register/utils/check_command with storage bs:ctx _
execute unless score #s bs.ctx matches 1 run return run function bs.interaction:register/errors/command { event: "on_hover_leave" }

execute unless function bs.interaction:register/utils/executor/setup \
  run return run function bs.interaction:register/errors/executor { event: "on_hover_leave" }

execute if score #i bs.ctx matches 2.. run function #bs.log:warn { \
  namespace: bs.interaction, \
  path: "#bs.interaction:on_hover_leave", \
  tag: "on_hover_leave", \
  message: ["The selector points to multiple entities. Only the first one is selected."] \
}

tag @s add bs.interaction.is_hoverable
tag @s add bs.interaction.listen_hover_leave
schedule function bs.interaction:on_event/process 1t replace
return run function bs.interaction:register/utils/setup_listener
