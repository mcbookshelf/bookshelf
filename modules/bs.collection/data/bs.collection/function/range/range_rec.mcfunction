execute if score #step bs.ctx matches 1.. if score #m bs.ctx < #n bs.ctx run function bs.collection:range/add
execute if score #step bs.ctx matches ..-1 if score #m bs.ctx > #n bs.ctx run function bs.collection:range/add
