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

forceload add -30000000 1600
execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],alignment:"center",view_range:0f,alignment:"center"}
setblock -30000000 0 1605 minecraft:repeating_command_block[facing=up]{auto:1b,Command:"help me",TrackOutput:1b}

schedule function bs.log:__tick__ 1t

scoreboard objectives add bs.in dummy [{"text":"BS ","color":"dark_gray"},{"text":"Input","color":"aqua"}]
scoreboard objectives add bs.ctx dummy [{"text":"BS ","color":"dark_gray"},{"text":"Context","color":"aqua"}]
scoreboard objectives add bs.data dummy [{"text":"BS ","color":"dark_gray"},{"text":"Data","color":"aqua"}]

execute unless score #log.gametime bs.data matches -2147483648..2147483647 store result score #log.gametime bs.data run time query gametime

data modify storage bs:const log.time_hms set value '[{"nbt": "log.hours", "storage": "bs:in"}, {"text": ":"}, {"nbt": "log.minutes", "storage": "bs:in"}, {"text": ":"}, {"nbt": "log.seconds", "storage": "bs:in"}]'
data modify storage bs:const log.time_hmst set value '[{"nbt": "log.time_hms", "storage": "bs:const", "interpret": true}, {"text": "."}, {"nbt": "log.ticks", "storage": "bs:in"}, "t"]'

data modify storage bs:const log.messages[{default: true}].format set value { \
  debug: '["",{"text":"🧪 ","color":"#BA76D6","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"🧪 [DEBUG]\\n","color":"#BA76D6"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  info: '["",{"text":"ℹ ","color":"#43A8EC","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"ℹ [INFO]\\n","color":"#43A8EC"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  warn: '["",{"text":"⚠ ","color":"#F3B512","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"⚠ [WARN]\\n","color":"#F3B512"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  error: '["",{"text":"❌ ","color":"#E84635","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"❌ [ERROR]\\n","color":"#E84635"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
}

data modify storage bs:const log.messages[{namespaces: ["bs"]}].format set value { \
  debug: '["",{"text":"🧪 ","color":"#BA76D6","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"🧪 [DEBUG] <Bookshelf>\\n","color":"#BA76D6"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  info: '["",{"text":"ℹ ","color":"#43A8EC","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"ℹ [INFO] <Bookshelf>\\n","color":"#43A8EC"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  warn: '["",{"text":"⚠ ","color":"#F3B512","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"⚠ [WARN] <Bookshelf>\\n","color":"#F3B512"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
  error: '["",{"text":"❌ ","color":"#E84635","extra":["[",{"storage":"bs:in","nbt":"log.namespace"},"] ",{"storage":"bs:in","nbt":"log.tag","color":"gray"}],"hoverEvent":{"action":"show_text","contents":["",{"text":"❌ [ERROR] <Bookshelf>\\n","color":"#E84635"},{"text":"Timestamp: ","color":"gray"},{"storage":"bs:const","nbt":"log.time_hmst","interpret":true},"\\n",{"text":"Function: ","color":"gray"},{"nbt":"log.path","storage":"bs:in"}]}},{"text":" > ","color":"gray"},{"storage":"bs:in","nbt":"log.message","interpret":true}]', \
}
