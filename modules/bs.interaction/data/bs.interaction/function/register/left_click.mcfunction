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

execute unless entity @s[type=interaction] run return run function #bs.log:error { \
  namespace: bs.interaction, \
  path: "#bs.interaction:on_left_click", \
  tag: "on_left_click", \
  message: '"The current entity is not an interaction."', \
}
$data modify storage bs:ctx _ set value { run: '$(run)', executor: $(executor), type: "left_click" }

execute store success score #s bs.ctx run function bs.interaction:register/utils/check_command with storage bs:ctx _
execute unless score #s bs.ctx matches 1 run return run function #bs.log:error { \
  namespace: bs.interaction, \
  path: "#bs.interaction:on_left_click", \
  tag: "on_left_click", \
  message: '"The command is not valid."', \
}

execute unless function bs.interaction:register/utils/executor/setup \
  run return run function #bs.log:error { \
    namespace: bs.interaction, \
    path: "#bs.interaction:on_left_click", \
    tag: "on_left_click", \
    message: '"The executor is not valid or cannot be interpreted."', \
  }

execute if score #i bs.ctx matches 2.. run function #bs.log:warn { \
  namespace: bs.interaction, \
  path: "#bs.interaction:on_left_click", \
  tag: "on_left_click", \
  message: '"The selector points to multiple entities. Only the first one is selected."' \
}

tag @s add bs.interaction.listen_left_click
return run function bs.interaction:register/utils/setup_listener
