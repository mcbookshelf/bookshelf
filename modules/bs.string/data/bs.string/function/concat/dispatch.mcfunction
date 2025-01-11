# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/string.html#concat
# ------------------------------------------------------------------------------------------------------------

# Modified from https://github.com/CMDred/StringLib/

$execute if score #n bs.ctx matches ..8 run return run function bs.string:concat/combine/$(x)

execute if score #n bs.ctx matches 2048.. run function bs.string:concat/combine/2048
execute if score #n bs.ctx matches 1024.. run function bs.string:concat/combine/1024
execute if score #n bs.ctx matches 512.. run function bs.string:concat/combine/512
execute if score #n bs.ctx matches 256.. run function bs.string:concat/combine/256
execute if score #n bs.ctx matches 128.. run function bs.string:concat/combine/128
execute if score #n bs.ctx matches 64.. run function bs.string:concat/combine/64
execute if score #n bs.ctx matches 32.. run function bs.string:concat/combine/32
execute if score #n bs.ctx matches 16.. run function bs.string:concat/combine/16
execute if score #n bs.ctx matches 8.. run function bs.string:concat/combine/8
execute if score #n bs.ctx matches 4.. run function bs.string:concat/combine/4
execute if score #n bs.ctx matches 2.. run function bs.string:concat/combine/2
execute if score #n bs.ctx matches 1.. run function bs.string:concat/combine/1
