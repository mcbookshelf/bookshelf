
execute positioned -2.0 0.3 1.7 run function #bs.geometry:get_point
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert data storage bs.geometry:get_shape out{type:"point"}

execute positioned 2.0 0.3 1.7 rotated 37 -25 run function #bs.geometry:get_plane
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result -546..-544 run data get storage bs.geometry:get_shape out.k[0] 1000
assert result 421..423 run data get storage bs.geometry:get_shape out.k[1] 1000
assert result 722..724 run data get storage bs.geometry:get_shape out.k[2] 1000
assert data storage bs.geometry:get_shape out{type:"plane"}

execute positioned 2.0 0.3 1.7 rotated 37 -25 run function #bs.geometry:get_line
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result -546..-544 run data get storage bs.geometry:get_shape out.k[0] 1000
assert result 421..423 run data get storage bs.geometry:get_shape out.k[1] 1000
assert result 722..724 run data get storage bs.geometry:get_shape out.k[2] 1000
assert data storage bs.geometry:get_shape out{type:"line"}

data modify storage bs.geometry:get_shape in.radius set value 3.6f
execute positioned 2.0 0.3 1.7 run function #bs.geometry:get_sphere
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result 3599..3601 run data get storage bs.geometry:get_shape out.radius 1000
assert data storage bs.geometry:get_shape out{type:"sphere"}

execute positioned 2.0 0.3 1.7 rotated 37 -25 run function #bs.geometry:get_cartesian_space
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result 797..799 run data get storage bs.geometry:get_shape out.i[0] 1000
assert result -1..1 run data get storage bs.geometry:get_shape out.i[1] 1000
assert result 600..602 run data get storage bs.geometry:get_shape out.i[2] 1000
assert result 253..255 run data get storage bs.geometry:get_shape out.j[0] 1000
assert result 905..907 run data get storage bs.geometry:get_shape out.j[1] 1000
assert result -338..-336 run data get storage bs.geometry:get_shape out.j[2] 1000
assert result -546..-544 run data get storage bs.geometry:get_shape out.k[0] 1000
assert result 421..423 run data get storage bs.geometry:get_shape out.k[1] 1000
assert result 722..724 run data get storage bs.geometry:get_shape out.k[2] 1000
assert data storage bs.geometry:get_shape out{type:"coord_space"}
assert data storage bs.geometry:get_shape out{coord_type:"cartesian"}

execute positioned 2.0 0.3 1.7 rotated 37 -25 run function #bs.geometry:get_spherical_space
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result 797..799 run data get storage bs.geometry:get_shape out.i[0] 1000
assert result -1..1 run data get storage bs.geometry:get_shape out.i[1] 1000
assert result 600..602 run data get storage bs.geometry:get_shape out.i[2] 1000
assert result 253..255 run data get storage bs.geometry:get_shape out.j[0] 1000
assert result 905..907 run data get storage bs.geometry:get_shape out.j[1] 1000
assert result -338..-336 run data get storage bs.geometry:get_shape out.j[2] 1000
assert result -546..-544 run data get storage bs.geometry:get_shape out.k[0] 1000
assert result 421..423 run data get storage bs.geometry:get_shape out.k[1] 1000
assert result 722..724 run data get storage bs.geometry:get_shape out.k[2] 1000
assert data storage bs.geometry:get_shape out{type:"coord_space"}
assert data storage bs.geometry:get_shape out{coord_type:"spherical"}

execute positioned 2.0 0.3 1.7 rotated 37 -25 run function #bs.geometry:get_cylindric_space
assert result 1999..2001 run data get storage bs.geometry:get_shape out.origin[0] 1000
assert result 299..301 run data get storage bs.geometry:get_shape out.origin[1] 1000
assert result 1699..1700 run data get storage bs.geometry:get_shape out.origin[2] 1000
assert result 797..799 run data get storage bs.geometry:get_shape out.i[0] 1000
assert result -1..1 run data get storage bs.geometry:get_shape out.i[1] 1000
assert result 600..602 run data get storage bs.geometry:get_shape out.i[2] 1000
assert result 253..255 run data get storage bs.geometry:get_shape out.j[0] 1000
assert result 905..907 run data get storage bs.geometry:get_shape out.j[1] 1000
assert result -338..-336 run data get storage bs.geometry:get_shape out.j[2] 1000
assert result -546..-544 run data get storage bs.geometry:get_shape out.k[0] 1000
assert result 421..423 run data get storage bs.geometry:get_shape out.k[1] 1000
assert result 722..724 run data get storage bs.geometry:get_shape out.k[2] 1000
assert data storage bs.geometry:get_shape out{type:"coord_space"}
assert data storage bs.geometry:get_shape out{coord_type:"cylindric"}
