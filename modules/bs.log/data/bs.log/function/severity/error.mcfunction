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

$data modify storage bs:in log merge value {severity: "error", namespace: "$(namespace)", tag: "$(tag)", path: "$(path)", message: '$(message)'}

data modify storage bs:data log.message set from storage bs:const log.messages[{default: true}].format.error
$data modify storage bs:data log.message set from storage bs:const log.messages[{namespaces: ["$(namespace)"]}].format.error

$execute as @a unless entity @s[ \
  tag=!$(namespace).log.$(tag).debug, \
  tag=!$(namespace).log.$(tag).info, \
  tag=!$(namespace).log.$(tag).warn, \
  tag=!$(namespace).log.$(tag).error, \
  tag=!$(namespace).log._.debug, \
  tag=!$(namespace).log._.info, \
  tag=!$(namespace).log._.warn, \
  tag=!$(namespace).log._.error, \
  tag=!$(namespace).log._._, \
  tag=!$(namespace).log.$(tag)._, \
  tag=!_.log.$(tag).debug, \
  tag=!_.log.$(tag).info, \
  tag=!_.log.$(tag).warn, \
  tag=!_.log.$(tag).error, \
  tag=!_.log._.debug, \
  tag=!_.log._.info, \
  tag=!_.log._.warn, \
  tag=!_.log._.error, \
  tag=!_.log.$(tag)._, \
  tag=!_.log._._ \
] run tellraw @s {"storage": "bs:data", "nbt": "log.message", "interpret": true}
