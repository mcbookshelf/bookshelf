data modify storage bs.geometry:intersect in set value []

execute positioned 8 -60 8 rotated 45 45 run function #bs.geometry:get_plane
data modify storage bs.geometry:intersect in append from storage bs.geometry:get_shape out

execute positioned 8 -60 -8 rotated 15 30 run function #bs.geometry:get_line
data modify storage bs.geometry:intersect in append from storage bs.geometry:get_shape out

function #bs.geometry:intersect

assert result 5970..5972 run data get storage bs.geometry:intersect out[-1].origin[0]
assert result -64526..-64524 run data get storage bs.geometry:intersect out[-1].origin[1]
assert result -429..-427 run data get storage bs.geometry:intersect out[-1].origin[2]
