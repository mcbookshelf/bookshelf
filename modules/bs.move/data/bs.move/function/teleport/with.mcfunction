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

data modify storage bs:data move set value { \
  blocks: true, \
  entities: false, \
  hitbox_shape: "collision", \
  on_collision: "function #bs.move:callback/bounce", \
  ignored_blocks: "#bs.hitbox:can_pass_through", \
  ignored_entities: "#bs.hitbox:intangible", \
}
$data modify storage bs:data move merge value $(with)
