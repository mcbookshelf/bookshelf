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

$data modify storage bs.generation: task merge value {line:"bs.generation:on_cuboid_outline/step_i/$(line_n)",to_next_slice:"$(k_pre)1$(k_post)",to_slice_after_face:"$(j_back)$(last_j)$(j_post) positioned $(k_pre)1$(k_post)",to_edge_3:"$(i_pre)$(last_i)$(i_post) positioned $(j_pre)1$(j_post)",to_edge_4:"$(j_pre)$(last_j)$(j_post)"}
