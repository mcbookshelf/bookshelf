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
# ------------------------------------------------------------------------------------------------------------

# grindstone group
execute if block ~ ~ ~ minecraft:grindstone[facing=west,face=floor] run data modify storage bs:out hitbox.shape set value [[6, 0, 2, 10, 7, 4],[6, 0, 12, 10, 7, 14],[5, 7, 2, 11, 13, 4],[5, 7, 12, 11, 13, 14],[2, 4, 4, 14, 16, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=east,face=floor] run data modify storage bs:out hitbox.shape set value [[6, 0, 2, 10, 7, 4],[6, 0, 12, 10, 7, 14],[5, 7, 2, 11, 13, 4],[5, 7, 12, 11, 13, 14],[2, 4, 4, 14, 16, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=north,face=floor] run data modify storage bs:out hitbox.shape set value [[2, 0, 6, 4, 7, 10],[12, 0, 6, 14, 7, 10],[2, 7, 5, 4, 13, 11],[12, 7, 5, 14, 13, 11],[4, 4, 2, 12, 16, 14]]
execute if block ~ ~ ~ minecraft:grindstone[facing=south,face=floor] run data modify storage bs:out hitbox.shape set value [[2, 0, 6, 4, 7, 10],[12, 0, 6, 14, 7, 10],[2, 7, 5, 4, 13, 11],[12, 7, 5, 14, 13, 11],[4, 4, 2, 12, 16, 14]]
execute if block ~ ~ ~ minecraft:grindstone[facing=west,face=wall] run data modify storage bs:out hitbox.shape set value [[7, 6, 2, 16, 10, 4],[7, 6, 12, 16, 10, 14],[3, 5, 2, 9, 11, 4],[3, 5, 12, 9, 11, 14],[0, 2, 4, 12, 14, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=east,face=wall] run data modify storage bs:out hitbox.shape set value [[0, 6, 2, 9, 10, 4],[0, 6, 12, 9, 10, 14],[7, 5, 2, 13, 11, 4],[7, 5, 12, 13, 11, 14],[4, 2, 4, 16, 14, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=north,face=wall] run data modify storage bs:out hitbox.shape set value [[2, 6, 7, 4, 10, 16],[12, 6, 7, 14, 10, 16],[2, 5, 3, 4, 11, 9],[12, 5, 3, 14, 11, 9],[4, 2, 0, 12, 14, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=south,face=wall] run data modify storage bs:out hitbox.shape set value [[2, 6, 0, 4, 10, 7],[12, 6, 0, 14, 10, 7],[2, 5, 7, 4, 11, 13],[12, 5, 7, 14, 11, 13],[4, 2, 4, 12, 14, 16]]
execute if block ~ ~ ~ minecraft:grindstone[facing=west,face=ceiling] run data modify storage bs:out hitbox.shape set value [[6, 9, 2, 10, 16, 4],[6, 9, 12, 10, 16, 14],[5, 3, 2, 11, 9, 4],[5, 3, 12, 11, 9, 14],[2, 0, 4, 14, 12, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=east,face=ceiling] run data modify storage bs:out hitbox.shape set value [[6, 9, 2, 10, 16, 4],[6, 9, 12, 10, 16, 14],[5, 3, 2, 11, 9, 4],[5, 3, 12, 11, 9, 14],[2, 0, 4, 14, 12, 12]]
execute if block ~ ~ ~ minecraft:grindstone[facing=north,face=ceiling] run data modify storage bs:out hitbox.shape set value [[2, 9, 6, 4, 16, 10],[12, 9, 6, 14, 16, 10],[2, 3, 5, 4, 9, 11],[12, 3, 5, 14, 9, 11],[4, 0, 2, 12, 12, 14]]
execute if block ~ ~ ~ minecraft:grindstone[facing=south,face=ceiling] run data modify storage bs:out hitbox.shape set value [[2, 9, 6, 4, 16, 10],[12, 9, 6, 14, 16, 10],[2, 3, 5, 4, 9, 11],[12, 3, 5, 14, 9, 11],[4, 0, 2, 12, 12, 14]]
