# chest group
data modify storage bs:out hitbox set value [[1, 0, 1, 15, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=west,type=left] run data modify storage bs:out hitbox set value [[1, 0, 0, 15, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=east,type=left] run data modify storage bs:out hitbox set value [[1, 0, 1, 15, 14, 16]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=north,type=left] run data modify storage bs:out hitbox set value [[1, 0, 1, 16, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=south,type=left] run data modify storage bs:out hitbox set value [[0, 0, 1, 15, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=west,type=right] run data modify storage bs:out hitbox set value [[1, 0, 1, 15, 14, 16]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=east,type=right] run data modify storage bs:out hitbox set value [[1, 0, 0, 15, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=north,type=right] run data modify storage bs:out hitbox set value [[0, 0, 1, 15, 14, 15]]
execute if block ~ ~ ~ #bs.hitbox:chest[facing=south,type=right] run data modify storage bs:out hitbox set value [[1, 0, 1, 16, 14, 15]]
