# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

data modify storage bs:data raycast set value { \
  sx: 1, \
  sy: 1, \
  sz: 1, \
  blocks: true, \
  entities: false, \
  ignored_blocks: "#bs.view:can_see_through", \
  ignored_entities: "#bs.hitbox:intangible", \
  data: {hit_point:1b,hit_normal:1b,targeted_block:1b,targeted_entity:1b}, \
}
$data modify storage bs:data raycast merge value $(with)
