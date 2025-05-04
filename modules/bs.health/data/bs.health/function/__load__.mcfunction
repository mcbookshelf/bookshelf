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

forceload add -30000000 1600
execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f,alignment:"center"}

scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]
scoreboard objectives add bs.const dummy [{text:"BS ",color:"dark_gray"},{text:"Constants",color:"aqua"}]
scoreboard objectives add bs.hmod dummy [{text:"BS ",color:"dark_gray"},{text:"Health Modifier",color:"aqua"}]
scoreboard objectives add bs.hval dummy [{text:"BS ",color:"dark_gray"},{text:"Health Value",color:"aqua"}]
scoreboard objectives add bs.ttl dummy [{text:"BS ",color:"dark_gray"},{text:"Time to Live",color:"aqua"}]

scoreboard players set 10 bs.const 10

data modify storage bs:data health.div set value [0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f]

data modify storage bs:const health.point set value 100000
data modify storage bs:const health.units set value [ \
  {name:"t",scale:1}, \
  {name:"tick",scale:1}, \
  {name:"s",scale:20}, \
  {name:"second",scale:20}, \
  {name:"m",scale:1200}, \
  {name:"minute",scale:1200}, \
  {name:"hour",scale:72000}, \
  {name:"h",scale:72000}, \
]
