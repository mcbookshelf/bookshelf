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

data modify storage bs:data block._ set value { \
  mask: "", \
  pos: [0d, 0d, 0d], \
  mode: "replace", \
  limit: 4096, \
  masks: [], \
  impl: "set_type", \
}
data modify storage bs:data block._ merge from storage bs:in block.fill_type

execute if data storage bs:data block._.masks[0] run function bs.block:utils/masks/compile
execute summon minecraft:marker run function bs.block:fill/recurse/init
